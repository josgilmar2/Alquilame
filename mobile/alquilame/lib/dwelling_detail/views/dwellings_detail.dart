import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingsDetail extends StatefulWidget {
  const DwellingsDetail({super.key});

  @override
  State<DwellingsDetail> createState() => _DwellingsDetailState();
}

class _DwellingsDetailState extends State<DwellingsDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DwellingDetailBloc, DwellingDetailState>(
      builder: (context, state) {
        switch (state.status) {
          case DwellingDetailStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("No se puede valorar una vivienda dos veces"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Volver"),
                  ),
                ],
              ),
            );
          case DwellingDetailStatus.success:
            return DwellingDetailScreen(
              dwellingDetail: state.dwellingDetail,
              userResponse: state.userResponse,
              superContext: context,
            );
          case DwellingDetailStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
