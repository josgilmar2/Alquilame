import 'dart:async';

import 'package:alquilame/user_manage/user_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPasswordBloc(),
      child: Builder(
        builder: (context) {
          final editPasswordBloc = context.read<EditPasswordBloc>();
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              )),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Edita tu contraseña"),
                backgroundColor: Colors.black87,
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[300],
              body: SafeArea(
                child: FormBlocListener<EditPasswordBloc, String, String>(
                  onSubmitting: (context, state) =>
                      EditPasswordDialog.show(context),
                  onSubmissionFailed: (context, state) =>
                      EditPasswordDialog.hide(context),
                  onSuccess: (context, state) {
                    EditPasswordDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("La contraseña se ha cambiado con éxito"),
                    ));
                    Timer(const Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                    });
                  },
                  onFailure: (context, state) {
                    EditPasswordDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.failureResponse!),
                      duration: const Duration(seconds: 7),
                    ));
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Center(
                          child: Image.network(
                              "https://dewey.tailorbrands.com/production/brand_version_mockup_image/222/8144028222_82dd4f72-f25a-4ff0-be13-94a4ed9d3fa9.png?cb=1676809534"),
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                              label: Text("Old Password"),
                              prefixIcon: Icon(Icons.fingerprint)),
                          textFieldBloc: editPasswordBloc.oldPassword,
                          keyboardType: TextInputType.visiblePassword,
                          suffixButton: SuffixButton.obscureText,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                              label: Text("New Password"),
                              prefixIcon: Icon(Icons.fingerprint)),
                          textFieldBloc: editPasswordBloc.newPassword,
                          keyboardType: TextInputType.visiblePassword,
                          suffixButton: SuffixButton.obscureText,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                              label: Text("Verify New Password"),
                              prefixIcon: Icon(Icons.fingerprint)),
                          textFieldBloc: editPasswordBloc.verifyNewPassword,
                          keyboardType: TextInputType.visiblePassword,
                          suffixButton: SuffixButton.obscureText,
                        ),
                        ElevatedButton(
                          onPressed: editPasswordBloc.submit,
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black87)),
                          child: const Text("Cambiar contraseña"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditPasswordDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => EditPasswordDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const EditPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
