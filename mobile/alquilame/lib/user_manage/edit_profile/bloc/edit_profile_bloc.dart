import 'dart:async';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/services/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditProfileBloc extends FormBloc<String, String> {
  late final UserService _userService;

  final address = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final phoneNumber = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final fullName = TextFieldBloc(validators: [FieldBlocValidators.required]);

  EditProfileBloc() {
    _userService = getIt<UserService>();
    addFieldBlocs(fieldBlocs: [address, phoneNumber, fullName]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      await _userService.editProfile(
          address.value, phoneNumber.value, fullName.value);
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
