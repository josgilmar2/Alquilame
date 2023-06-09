import 'dart:convert';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/rest/rest.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

@Order(-1)
@singleton
class DwellingRepository {
  late RestAuthenticatedClient _client;

  DwellingRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<AllDwellingsResponse> getAllDwellings(int starterIndex) async {
    String url = "/dwelling/?page=$starterIndex";
    var jsonResponse = await _client.get(url);
    return AllDwellingsResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<OneDwellingResponse> getOneDwelling(int id) async {
    String url = "/dwelling/$id";
    var jsonResponse = await _client.get(url);
    return OneDwellingResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<AllDwellingsResponse> getUserDwellings(int page) async {
    String url = "/dwelling/user?page=$page";
    var jsonResponse = await _client.get(url);
    return AllDwellingsResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<OneDwellingResponse> markAsFavourite(int id) async {
    String url = "/dwelling/$id/favourite";
    var jsonResponse = await _client.post(url);
    return OneDwellingResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<void> deleteFavourite(int id) async {
    String url = "/dwelling/$id/favourite";
    await _client.delete(url);
  }

  Future<OneDwellingResponse> createDwellingMultipart(
      DwellingRequest request, PlatformFile file, String accessToken) async {
    String url = "/dwelling/";

    var jsonResponse =
        await _client.postMultipart(url, request, file, accessToken);
    return OneDwellingResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<void> deleteDwelling(int id) async {
    String url = "/dwelling/$id";
    await _client.delete(url);
  }

  Future<OneDwellingResponse> rateDwelling(
      int id, double score, String? comment) async {
    String url = "/dwelling/$id/rate";
    var jsonResponse =
        await _client.post(url, RatingRequest(score: score, comment: comment));
    return OneDwellingResponse.fromJson(jsonDecode(jsonResponse));
  }
}
