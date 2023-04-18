import 'dart:convert';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/rest/rest.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@Order(-1)
@singleton
class AuthRepository {
  late RestClient _client;

  AuthRepository() {
    _client = GetIt.I.get<RestClient>();
  }

  Future<dynamic> doLogin(String username, String password) async {
    String url = "/auth/login";

    var jsonResponse = await _client.post(
        url, LoginRequest(username: username, password: password));
    return LoginResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<dynamic> doRegisterPropietario(
      String username,
      String email,
      String address,
      String phoneNumber,
      String fullName,
      String password,
      String verifyPassword) async {
    String url = "/auth/register/propietario";

    var jsonResponse = await _client.post(
        url,
        UserRequest(
            username: username,
            email: email,
            address: address,
            phoneNumber: phoneNumber,
            fullName: fullName,
            password: password,
            verifyPassword: verifyPassword));
    return UserResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<dynamic> doRegisterInquilino(
      String username,
      String email,
      String address,
      String phoneNumber,
      String fullName,
      String password,
      String verifyPassword) async {
    String url = "/auth/register/inquilino";

    var jsonResponse = await _client.post(
        url,
        UserRequest(
            username: username,
            email: email,
            address: address,
            phoneNumber: phoneNumber,
            fullName: fullName,
            password: password,
            verifyPassword: verifyPassword));
    return UserResponse.fromJson(jsonDecode(jsonResponse));
  }
}
