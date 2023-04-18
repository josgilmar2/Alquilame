import 'package:alquilame/config/locator.dart';
import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:alquilame/dwelling_favourite/dwelling_favourite.dart';
import 'package:alquilame/favourite/favourite.dart';
import 'package:alquilame/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingDetailPage extends StatelessWidget {
  const DwellingDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final dwellingService = getIt<DwellingService>();
            return DwellingDetailBloc(dwellingService)
              ..add(DwellingDetailFetched(id));
          }),
          BlocProvider(
            create: (context) {
              final dwellingService = getIt<DwellingService>();
              return FavouriteBloc(dwellingService)..add(AddFavourite(id));
            },
          ),
          BlocProvider(
            create: (context) {
              final userService = getIt<UserService>();
              return DwellingFavouritesBloc(userService)
                ..add(DwellingFavouritesFetched());
            },
          )
        ],
        child: const DwellingsDetail(),
      ),
    );
  }
}
