import 'package:alquilame/dwelling/dwelling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alquilame/services/services.dart';
import 'package:alquilame/config/locator.dart';

class DwellingUserListPage extends StatelessWidget {
  const DwellingUserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tus viviendas"),
        backgroundColor: Colors.black87,
      ),
      body: BlocProvider(
        create: (context) {
          final dwellingService = getIt<DwellingService>();
          return DwellingBloc(dwellingService)..add(DwellingUserFetched());
        },
        child: const DwellingUserList(),
      ),
    );
  }
}
