import 'dart:convert';
import 'dart:io';

import 'package:alquilame/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../services/services.dart';

class ApiConstants {
  static String baseUrl = "http://localhost:8080";
}

class AuthorizationInterceptor implements InterceptorContract {
  late LocalStorageService _localStorageService;

  AuthorizationInterceptor() {
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      var token = await _localStorageService.getFromDisk("user_token");
      data.headers["Authorization"] = "Bearer " + token;
    } catch (e) {
      print(e);
    }
    return Future.value(data);
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) {
    if (data.statusCode == 401 || data.statusCode == 403) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(GlobalContext.ctx).push<void>(MyApp.route());
      });
    }
    return Future.value(data);
  }
}

class HeadersApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["Content-Type"] = "application/json";
      data.headers["Accept"] = "application/json";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

@Order(-10)
@singleton
class RestClient {
  var _httpClient;

  RestClient() {
    _httpClient =
        InterceptedClient.build(interceptors: [HeadersApiInterceptor()]);
  }

  RestClient.withInterceptors(List<InterceptorContract> interceptors) {
    if (interceptors
        .where((element) => element is HeadersApiInterceptor)
        .isEmpty) interceptors..add(HeadersApiInterceptor());
    _httpClient = InterceptedClient.build(interceptors: interceptors);
  }

  Future<dynamic> get(String url) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);

      final response = await _httpClient.get(uri);
      var responseJson = _response(response);
      return responseJson;
    } on Exception catch (ex) {
      throw ex;
    }
  }

  Future<dynamic> post(String url, [dynamic body]) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);

      final response = await _httpClient.post(uri, body: jsonEncode(body));
      var responseJson = _response(response);
      return responseJson;
    } on Exception catch (ex) {
      throw ex;
    }
  }

  Future<dynamic> postMultipart(
      String url, dynamic body, PlatformFile file, String accessToken) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);
      Map<String, String> headers = Map();
      headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $accessToken',
      });
      var bodyPart;
      var request = new http.MultipartRequest('POST', uri);
      final httpImage = http.MultipartFile.fromBytes('file', file.bytes!,
          contentType: MediaType('image', file.extension!),
          filename: file.name);
      request.files.add(httpImage);
      request.headers.addAll(headers);
      if (body != null) {
        bodyPart = http.MultipartFile.fromString('body', jsonEncode(body),
            contentType: MediaType('application', 'json'));
        request.files.add(bodyPart);
      }

      final response = await _httpClient!.send(request);
      var responseJson = response.stream.bytesToString();
      return responseJson;
    } on SocketException catch (e) {
      throw Exception("No internet connection: ${e.message}");
    }
  }

  Future<dynamic> putMultiPart(
      String url, dynamic body, PlatformFile file, String token) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);

      Map<String, String> headers = Map();
      headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${token}',
      });

      var request = new http.MultipartRequest('PUT', uri);
      final httpImage = http.MultipartFile.fromBytes('file', file.bytes!,
          contentType: MediaType('image', file.extension!),
          filename: file.name);
      request.files.add(httpImage);
      request.headers.addAll(headers);

      final response = await _httpClient!.send(request);
      var responseJson = response.stream.bytesToString();
      return responseJson;
    } on SocketException catch (ex) {
      throw Exception('No internet connection: ${ex.message}');
    }
  }

  Future<dynamic> put(String url, dynamic body) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);

      Map<String, String> headers = Map();
      headers.addAll({"Content-Type": "application/json"});

      final response =
          await _httpClient.put(uri, body: jsonEncode(body), headers: headers);
      var jsonResponse = _response(response);
      return jsonResponse;
    } on SocketException catch (e) {
      throw Exception("No internet connection: ${e.message}");
    }
  }

  Future<dynamic> delete(String url) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);

      final response = await _httpClient!.delete(uri);
      var jsonResponse = _response(response);
      return jsonResponse;
    } on SocketException catch (e) {
      throw Exception('No internet connection: ${e.message}');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 204:
        return;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes));
      case 401:
        throw AuthenticationException(
            "You have entered an invalid username or password");
      case 403:
        throw UnauthorizedException(utf8.decode(response.bodyBytes));
      case 404:
        throw NotFoundException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final message;
  final _prefix;

  CustomException([this.message, this._prefix]);

  String toString() {
    return "$_prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class AuthenticationException extends CustomException {
  AuthenticationException([message]) : super(message, "");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message, "");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "");
}

@Order(-10)
@singleton
class RestAuthenticatedClient extends RestClient {
  RestAuthenticatedClient()
      : super.withInterceptors(
            List.of(<InterceptorContract>[AuthorizationInterceptor()]));
}
