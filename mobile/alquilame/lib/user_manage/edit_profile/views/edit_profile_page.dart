import 'dart:async';

import 'package:alquilame/user_manage/user_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: Builder(
        builder: (context) {
          final editProfileBloc = context.read<EditProfileBloc>();
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              )),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Edita tu perfil de usuario"),
                backgroundColor: Colors.black87,
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[300],
              body: SafeArea(
                child: FormBlocListener<EditProfileBloc, String, String>(
                  onSubmitting: (context, state) =>
                      EditProfileDialog.show(context),
                  onSubmissionFailed: (context, state) =>
                      EditProfileDialog.hide(context),
                  onSuccess: (context, state) {
                    EditProfileDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("El perfil se ha editado con éxito"),
                    ));
                    Timer(const Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                    });
                  },
                  onFailure: (context, state) {
                    EditProfileDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.failureResponse!),
                        duration: const Duration(seconds: 7)));
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Center(
                          child: Image.network(
                              "https://dewey.tailorbrands.com/production/brand_version_mockup_image/222/8144028222_82dd4f72-f25a-4ff0-be13-94a4ed9d3fa9.png?cb=1676809534"),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                              label: Text("Address"),
                              prefixIcon: Icon(Icons.location_city_outlined)),
                          textFieldBloc: editProfileBloc.address,
                          keyboardType: TextInputType.streetAddress,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                              label: Text("Phone Number"),
                              prefixIcon: Icon(Icons.phone_iphone_outlined)),
                          textFieldBloc: editProfileBloc.phoneNumber,
                          keyboardType: TextInputType.phone,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                              label: Text("Full Name"),
                              prefixIcon: Icon(Icons.person_2_outlined)),
                          textFieldBloc: editProfileBloc.fullName,
                          keyboardType: TextInputType.name,
                        ),
                        ElevatedButton(
                          onPressed: editProfileBloc.submit,
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black87)),
                          child: const Text("Editar perfil"),
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

class EditProfileDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => EditProfileDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const EditProfileDialog({Key? key}) : super(key: key);

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
