import 'dart:async';

import 'package:alquilame/config/locator.dart';
import 'package:alquilame/services/user_service.dart';
import 'package:file_picker/file_picker.dart';
// ignore: implementation_imports
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditAvatarBloc extends FormBloc<String, String> {
  late final UserService _userService;
  late PlatformFile file;

  EditAvatarBloc({Key? key}) {
    _userService = getIt<UserService>();
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      await _userService.editAvatar(file);
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }

  void saveImg(PlatformFile newFile) {
    file = newFile;
  }
}
