import 'dart:convert';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/rest/rest.dart';
import 'package:injectable/injectable.dart';

@Order(-1)
@singleton
class RentalRepository {
  late RestAuthenticatedClient _client;

  RentalRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<RentalResponse> createRental(int id, RentalRequest request) async {
    String url = "/rental/$id";
    var jsonResponse = await _client.post(url, request);
    return RentalResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<dynamic> confirmRental(String stripeId) async {
    String url = "/rental/confirm/$stripeId";
    await _client.post(url);
  }

  Future<dynamic> cancelRental(String stripeId) async {
    String url = "/rental/cancel/$stripeId";
    await _client.post(url);
  }
}
