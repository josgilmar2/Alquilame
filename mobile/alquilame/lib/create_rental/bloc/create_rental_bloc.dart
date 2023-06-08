import 'dart:async';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/services/rental_service.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateRentalBloc extends FormBloc<String, String> {
  late final RentalService _rentalService;
  final int id;
  late String stripeId;
  final startDate = InputFieldBloc<DateTime?, Object>(
    name: 'Start Date',
    initialValue: null,
    toJson: (value) => value!.toUtc().toIso8601String(),
  );
  final endDate = InputFieldBloc<DateTime?, Object>(
    name: 'End Date',
    initialValue: null,
    toJson: (value) => value!.toUtc().toIso8601String(),
  );

  CreateRentalBloc(RentalService rentalService, this.id) {
    _rentalService = getIt<RentalService>();
    addFieldBlocs(fieldBlocs: [startDate, endDate]);
  }

  @override
  FutureOr<void> onSubmitting() async {}

  Future<void> createRental() async {
    emitSubmitting();
    try {
      _rentalService
          .createRental(id,
              RentalRequest(startDate: startDate.value, endDate: endDate.value))
          .then((value) => stripeId = value.stripePaymentIntentId!);
    } catch (e) {
      emitFailure();
    }
  }

  Future<dynamic> confirmRental() async {
    emitSubmitting();
    try {
      await _rentalService.confirmRental(stripeId).then((value) {
        emitSuccess();
      });
    } catch (e) {
      emitFailure();
    }
  }

  Future<dynamic> cancelRental() async {
    emitSubmitting();
    try {
      await _rentalService.cancelRental(stripeId).then((value) {
        emitSuccess();
      });
    } catch (e) {
      emitFailure();
    }
  }
}
