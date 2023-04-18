import 'package:equatable/equatable.dart';

abstract class DwellingFavouritesEvent extends Equatable {
  const DwellingFavouritesEvent();

  @override
  List<Object> get props => [];
}

class DwellingFavouritesFetched extends DwellingFavouritesEvent {}
