import 'dart:async';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/services/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterBloc extends FormBloc<String, String> {
  late final AuthService _authService;
  late final propietario = BooleanFieldBloc();

  final username = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final email = TextFieldBloc(
      validators: [FieldBlocValidators.required, FieldBlocValidators.email]);

  final address = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final phoneNumber = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final fullName = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final password = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final verifyPassword =
      TextFieldBloc(validators: [FieldBlocValidators.required]);

  RegisterBloc() {
    _authService = getIt<JwtAuthService>();
    addFieldBlocs(step: 0, fieldBlocs: [propietario]);
    addFieldBlocs(step: 1, fieldBlocs: [
      username,
      email,
      address,
      phoneNumber,
      fullName,
      password,
      verifyPassword
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    if (state.currentStep == 0) {
      emitSuccess();
    } else if (state.currentStep == 1) {
      if (password.value != verifyPassword.value) {
        password.addFieldError("Las contraseñas no coinciden");
        verifyPassword.addFieldError("Las contraseñas no coinciden");
        emitFailure();
      } else {
        try {
          if (propietario.value) {
            final response = await _authService.registerPropietario(
                username.value,
                email.value,
                address.value,
                phoneNumber.value,
                fullName.value,
                password.value,
                verifyPassword.value);
            emitSuccess();
          } else {
            final response = await _authService.registerInquilino(
                username.value,
                email.value,
                address.value,
                phoneNumber.value,
                fullName.value,
                password.value,
                verifyPassword.value);
            emitSuccess();
          }
        } catch (e) {
          emitFailure();
        }
      }
    }
  }
}
