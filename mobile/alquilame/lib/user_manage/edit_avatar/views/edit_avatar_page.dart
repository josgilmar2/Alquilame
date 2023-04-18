import 'dart:io';

import 'package:alquilame/main.dart';
import 'package:alquilame/user_manage/user_manage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditAvatarPage extends StatefulWidget {
  const EditAvatarPage({super.key});

  @override
  State<EditAvatarPage> createState() => _EditAvatarPageState();
}

class _EditAvatarPageState extends State<EditAvatarPage> {
  final picker = ImagePicker();
  late File _image;
  FilePickerResult? result;
  bool imgSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAvatarBloc(),
      child: Builder(
        builder: (context) {
          final editAvatarBloc = context.read<EditAvatarBloc>();
          return Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
              ),
              child: Scaffold(
                  appBar: AppBar(
                      title: const Text("Edita tu avatar"),
                      backgroundColor: Colors.black87),
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.grey[300],
                  body: SafeArea(
                      child: FormBlocListener<EditAvatarBloc, String, String>(
                    onSubmitting: (context, state) =>
                        EditAvatarDialog.show(context),
                    onSubmissionFailed: (context, state) =>
                        EditAvatarDialog.hide(context),
                    onSuccess: (context, state) {
                      EditAvatarDialog.hide(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ));
                    },
                    onFailure: (context, state) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Por favor, seleccione su nuevo avatar antes de guardar"),
                        duration: Duration(seconds: 7),
                      ));
                      EditAvatarDialog.hide(context);
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
                            TextButton(
                              onPressed: () async {
                                result = await FilePicker.platform.pickFiles(
                                    withData: true,
                                    allowMultiple: false,
                                    type: FileType.image);
                                setState(() {
                                  imgSelected = result != null;
                                });
                                if (imgSelected) {
                                  editAvatarBloc.saveImg(result!.files[0]);
                                }
                              },
                              child: const Text("Seleccione una imagen"),
                            ),
                            const SizedBox(height: 10),
                            if (imgSelected)
                              Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        File(result!.files[0].path!),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            result = null;
                                            imgSelected = false;
                                          });
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  ]),
                            if (imgSelected)
                              const SizedBox(
                                height: 10,
                              ),
                            ElevatedButton(
                              onPressed: editAvatarBloc.submit,
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black87)),
                              child: const Text("GUARDAR NUEVO AVATAR"),
                            )
                          ],
                        )),
                  ))));
        },
      ),
    );
  }
}

class EditAvatarDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => EditAvatarDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const EditAvatarDialog({Key? key}) : super(key: key);

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
