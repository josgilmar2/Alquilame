import 'package:equatable/equatable.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavourite extends FavouriteEvent {
  final int id;

  const AddFavourite(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteFavourite extends FavouriteEvent {
  final int id;

  const DeleteFavourite(this.id);

  @override
  List<Object> get props => [id];
}
