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
            return const Center(
              child: Text('Failed to fech the dwelling details'),
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
