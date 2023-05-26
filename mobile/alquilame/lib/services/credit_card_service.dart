import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/repositories/credit_card_repository.dart';
import 'package:alquilame/services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@Order(2)
@singleton
class CreditCardService {
  late LocalStorageService _localStorageService;
  late CreditCardRepository _creditCardRepository;

  CreditCardService() {
    _creditCardRepository = getIt<CreditCardRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  Future<List<CreditCardResponse>> getAllUserCreditCards() async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      List<CreditCardResponse> response =
          await _creditCardRepository.getUserCreditCards();
      return response;
    }
    throw Exception('Failed to load all user credit cards');
  }

  Future<CreditCardResponse> createCreditCard(CreditCardRequest request) async {
    String token = await _localStorageService.getFromDisk("user_token");
    if (token != null) {
      CreditCardResponse response =
          await _creditCardRepository.createCreditCard(request);
      return response;
    }
    throw Exception('Failed to create the credit card');
  }

  Future<CreditCardResponse> activateCreditCard(int id) async {
    String token = await _localStorageService.getFromDisk("user_token");
    if (token != null) {
      CreditCardResponse response =
          await _creditCardRepository.activeCreditCard(id);
      return response;
    }
    throw Exception("Failed to activate the card with id: $id");
  }
}
