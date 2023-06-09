import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/repositories/rental_repository.dart';
import 'package:alquilame/rest/rest_client.dart';
import 'package:alquilame/services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@Order(2)
@singleton
class RentalService {
  late LocalStorageService _localStorageService;
  late RentalRepository _rentalRepository;

  RentalService() {
    _rentalRepository = getIt<RentalRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  Future<RentalResponse> createRental(int id, RentalRequest request) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      RentalResponse response =
          await _rentalRepository.createRental(id, request);
      return response;
    }
    throw BadRequestException();
  }

  Future<dynamic> confirmRental(String stripeId) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      return await _rentalRepository.confirmRental(stripeId);
    }
    throw Exception("Failed to confirm rental");
  }

  Future<dynamic> cancelRental(String stripeId) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      return await _rentalRepository.cancelRental(stripeId);
    }
    throw Exception("Failed to confirm rental");
  }
}
