import 'dart:io';

import 'package:alquilame/create_dwelling/create_dwelling.dart';
import 'package:alquilame/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateDwellingPage extends StatefulWidget {
  const CreateDwellingPage({super.key});

  @override
  State<CreateDwellingPage> createState() => _CreateDwellingPageState();
}

class _CreateDwellingPageState extends State<CreateDwellingPage> {
  final picker = ImagePicker();
  late File _image;
  FilePickerResult? result;
  bool imgSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateDwellingBloc(),
      child: Builder(
        builder: (context) {
          final createDwellingBloc = context.read<CreateDwellingBloc>();
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              )),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[300],
              body: SafeArea(
                child: FormBlocListener<CreateDwellingBloc, String, String>(
                  onSubmitting: (context, state) =>
                      CreateDwellingDialog.show(context),
                  onSubmissionFailed: (context, state) =>
                      CreateDwellingDialog.hide(context),
                  onSuccess: (context, state) {
                    CreateDwellingDialog.hide(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ));
                  },
                  onFailure: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Recuerda que el precio debe ser mayor o igual a 100€, los m² mayores o igula a 30 y tanto el número de habitaciones como el debaños mayor o igual a 1. Además no olvides de seleccionar una bonita imagen de la vivienda a registrar."),
                      duration: Duration(seconds: 7),
                    ));
                    CreateDwellingDialog.hide(context);
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Image.network(
                            "https://dewey.tailorbrands.com/production/brand_version_mockup_image/222/8144028222_82dd4f72-f25a-4ff0-be13-94a4ed9d3fa9.png?cb=1676809534"),
                        const SizedBox(height: 25),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's name"),
                            prefixIcon: Icon(Icons.add_home_outlined),
                          ),
                          textFieldBloc: createDwellingBloc.name,
                          keyboardType: TextInputType.name,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's address"),
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                          textFieldBloc: createDwellingBloc.address,
                          keyboardType: TextInputType.streetAddress,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's description"),
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          textFieldBloc: createDwellingBloc.description,
                          keyboardType: TextInputType.multiline,
                        ),
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
                              createDwellingBloc.saveImg(result!.files[0]);
                            }
                          },
                          child: const Text("Seleccione una imagen"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                        RadioButtonGroupFieldBlocBuilder<String>(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's type"),
                            prefixIcon: Icon(Icons.home_outlined),
                          ),
                          selectFieldBloc: createDwellingBloc.type,
                          itemBuilder: (context, value) =>
                              FieldItem(child: Text(value)),
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's price"),
                            prefixIcon: Icon(Icons.euro_outlined),
                          ),
                          textFieldBloc: createDwellingBloc.price,
                          keyboardType: TextInputType.number,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's m²"),
                            prefixIcon:
                                Icon(Icons.assignment_turned_in_outlined),
                          ),
                          textFieldBloc: createDwellingBloc.m2,
                          keyboardType: TextInputType.number,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's number of bedrooms"),
                            prefixIcon: Icon(Icons.bed_outlined),
                          ),
                          textFieldBloc: createDwellingBloc.numBedrooms,
                          keyboardType: TextInputType.number,
                        ),
                        TextFieldBlocBuilder(
                          decoration: const InputDecoration(
                            label: Text("Dwelling's number of bathrooms"),
                            prefixIcon: Icon(Icons.wc_outlined),
                          ),
                          textFieldBloc: createDwellingBloc.numBathrooms,
                          keyboardType: TextInputType.number,
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: createDwellingBloc.hasElevator,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("¿Tiene ascensor?"),
                          ),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: createDwellingBloc.hasPool,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("¿Tiene piscina?"),
                          ),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: createDwellingBloc.hasTerrace,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("¿Tiene terraza?"),
                          ),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: createDwellingBloc.hasGarage,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("¿Tiene garaje?"),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: createDwellingBloc.provinceName,
                          decoration: const InputDecoration(
                              label: Text("Dwelling's province"),
                              prefixIcon: Icon(Icons.location_city_outlined)),
                          itemBuilder: (context, value) =>
                              FieldItem(child: Text(value)),
                        ),
                        ElevatedButton(
                          onPressed: createDwellingBloc.submit,
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black87)),
                          child: const Text("REGISTRAR"),
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

class CreateDwellingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => CreateDwellingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const CreateDwellingDialog({Key? key}) : super(key: key);

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
