import 'package:alquilame/config/locator.dart';
import 'package:alquilame/services/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditPasswordBloc extends FormBloc<String, String> {
  late final UserService _userService;

  final oldPassword = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final newPassword = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final verifyNewPassword =
      TextFieldBloc(validators: [FieldBlocValidators.required]);

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return 'Las nuevas contraseñas deben coincidir';
    };
  }

  Validator<String> _differentPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword != passwordTextFieldBloc.value) {
        return null;
      }
      return 'La contraseña nueva y antigua deben ser diferentes';
    };
  }

  EditPasswordBloc() {
    _userService = getIt<UserService>();
    addFieldBlocs(fieldBlocs: [oldPassword, newPassword, verifyNewPassword]);

    verifyNewPassword
      ..addValidators([_confirmPassword(newPassword)])
      ..subscribeToFieldBlocs([newPassword]);

    newPassword
      ..addValidators([_differentPassword(oldPassword)])
      ..subscribeToFieldBlocs([oldPassword]);
  }

  @override
  void onSubmitting() async {
    try {
      await _userService.editPassword(
          oldPassword.value, newPassword.value, verifyNewPassword.value);
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
