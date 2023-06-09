import 'package:alquilame/config/locator.dart';
import 'package:alquilame/create_rental/bloc/create_rental_bloc.dart';
import 'package:alquilame/dwelling_detail/widget/dwelling_detail_item.dart';
import 'package:alquilame/main.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/services/rental_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateRentalPage extends StatefulWidget {
  final OneDwellingResponse? dwellingResponse;

  const CreateRentalPage({super.key, required this.dwellingResponse});

  @override
  State<CreateRentalPage> createState() => _CreateRentalPageState();
}

class _CreateRentalPageState extends State<CreateRentalPage> {
  @override
  Widget build(BuildContext context) {
    RentalService _rentalService = getIt<RentalService>();
    return BlocProvider(
      create: (context) =>
          CreateRentalBloc(_rentalService, widget.dwellingResponse!.id),
      child: Builder(
        builder: (context) {
          final createRentalBloc = context.read<CreateRentalBloc>();
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Alquilame"),
                backgroundColor: Colors.black87,
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[300],
              body: SafeArea(
                child: FormBlocListener<CreateRentalBloc, String, String>(
                  onSubmitting: (context, state) =>
                      CreateRentalDialog.show(context),
                  onSubmissionFailed: (context, state) =>
                      CreateRentalDialog.hide(context),
                  onSuccess: (context, state) {
                    CreateRentalDialog.hide(context);
                    //showDialog(context: context, builder: )
                  },
                  onFailure: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Fallo"),
                      ),
                    );
                    CreateRentalDialog.hide(context);
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 25),
                        Image.network(
                            "https://dewey.tailorbrands.com/production/brand_version_mockup_image/222/8144028222_82dd4f72-f25a-4ff0-be13-94a4ed9d3fa9.png?cb=1676809534"),
                        const SizedBox(height: 25),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: createRentalBloc.startDate,
                          format: DateFormat('dd-MM-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          decoration: const InputDecoration(
                            labelText: 'Fecha de entrada',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: createRentalBloc.endDate,
                          format: DateFormat('dd-MM-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          decoration: const InputDecoration(
                            labelText: 'Fecha de salida',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(widget.dwellingResponse!.name),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          "El precio es ${(widget.dwellingResponse!.price * (createRentalBloc.endDate.value!.difference(createRentalBloc.startDate.value!).inDays)).toStringAsFixed(2)} € ¿Confirmas el pago?"),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        createRentalBloc
                                            .createRental()
                                            .then((value) {
                                          createRentalBloc
                                              .cancelRental(
                                                  value.stripePaymentIntentId!)
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Se ha cancelado el pago con éxito"),
                                              ),
                                            );
                                          });
                                        }).catchError((onError) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  onError.message.toString()),
                                            ),
                                          );
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Cancelar",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        createRentalBloc
                                            .createRental()
                                            .then((value) {
                                          createRentalBloc
                                              .confirmRental(
                                                  value.stripePaymentIntentId!)
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Se ha alquilado la vivienda con éxito"),
                                              ),
                                            );
                                          });
                                        }).catchError((onError) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "¡¡¡ERROR!!! Ya existe un alquiler durante estas fechas"),
                                              duration: Duration(seconds: 5),
                                            ),
                                          );
                                        });

                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      },
                                      child: const Text(
                                        "Alquilar",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black87),
                          ),
                          child: const Text(
                            "Pagar",
                          ),
                        ),
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

class CreateRentalDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => CreateRentalDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const CreateRentalDialog({Key? key}) : super(key: key);

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
