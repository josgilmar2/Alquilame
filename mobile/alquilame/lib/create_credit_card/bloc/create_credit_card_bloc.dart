import 'dart:async';

import 'package:alquilame/models/models.dart';
import 'package:alquilame/services/credit_card_service.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateCreditCardBloc extends FormBloc<String, String> {
  final CreditCardService _creditCardService;
  final number = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final holder = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final expiredDate = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final cvv = TextFieldBloc(validators: [FieldBlocValidators.required]);

  CreateCreditCardBloc(CreditCardService creditCardService)
      : assert(creditCardService != null),
        _creditCardService = creditCardService {
    number.addAsyncValidators([
      (value) {
        if (value.length != 16) {
          return Future(() => "El número de la tarjeta debe tener 16 dígitos");
        }
        return Future(() => null);
      }
    ]);
    cvv.addAsyncValidators([
      (value) {
        if (value.length != 3) {
          return Future(() => "El cvv debe de tener 3 dígitos");
        }
        return Future(() => null);
      }
    ]);
  }

  Future<CreditCardResponse> createCreditCard() async {
    return await _creditCardService.createCreditCard(CreditCardRequest(
      number: number.value.replaceAll(RegExp(r'\s+'), ''),
      holder: holder.value,
      expiredDate: expiredDate.value,
      cvv: cvv.value,
    ));
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      createCreditCard().then((value) {
        emitSuccess();
      });
    } catch (e) {
      emitFailure();
    }
  }
}
