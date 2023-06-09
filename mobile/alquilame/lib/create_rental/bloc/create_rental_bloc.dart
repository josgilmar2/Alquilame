import 'dart:async';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/services/rental_service.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

class CreateRentalBloc extends FormBloc<String, String> {
  late final RentalService _rentalService;
  final int id;
  final startDate = InputFieldBloc<DateTime?, Object>(
      name: 'Start Date',
      initialValue: null,
      toJson: (value) => value!.toUtc().toIso8601String(),
      validators: [FieldBlocValidators.required]);

  final endDate = InputFieldBloc<DateTime?, Object>(
      name: 'End Date',
      initialValue: null,
      toJson: (value) => value!.toUtc().toIso8601String(),
      validators: [FieldBlocValidators.required]);

  CreateRentalBloc(RentalService rentalService, this.id) {
    _rentalService = getIt<RentalService>();
    addFieldBlocs(fieldBlocs: [startDate, endDate]);
    initializeDateFormatting();
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      var format = DateFormat('dd/MM/yyyy');
      return format.format(date);
    }
    return '';
  }

  @override
  FutureOr<void> onSubmitting() async {}

  Future<RentalResponse> createRental() async {
    return _rentalService.createRental(
        id,
        RentalRequest(
            startDate: formatDate(startDate.value),
            endDate: formatDate(endDate.value)));
  }

  Future<dynamic> confirmRental(String stripeId) async {
    emitSubmitting();
    try {
      await _rentalService.confirmRental(stripeId).then((value) {
        emitSuccess();
      });
    } catch (e) {
      emitFailure();
    }
  }

  Future<dynamic> cancelRental(String stripeId) async {
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
