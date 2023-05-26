import 'dart:convert';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/credit_card.dart';
import 'package:alquilame/rest/rest.dart';
import 'package:injectable/injectable.dart';

@Order(-1)
@singleton
class CreditCardRepository {
  late RestAuthenticatedClient _client;

  CreditCardRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<List<CreditCardResponse>> getUserCreditCards() async {
    String url = "/creditcard/user";
    var jsonResponse = await _client.get(url);
    var list = (json.decode(jsonResponse) as List)
        .map((data) => CreditCardResponse.fromJson(data))
        .toList();
    return list;
  }

  Future<CreditCardResponse> createCreditCard(CreditCardRequest request) async {
    String url = "/creditcard/";
    var jsonResponse = await _client.post(url, request);
    return CreditCardResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<CreditCardResponse> activeCreditCard(int id) async {
    String url = "/creditcard/activate/$id";
    var jsonResponse = await _client.put(url);
    return CreditCardResponse.fromJson(jsonDecode(jsonResponse));
  }
}
