import 'package:alquilame/models/models.dart';
import 'package:equatable/equatable.dart';

enum FavouriteStatus { initial, success, failure }

class FavouriteState extends Equatable {
  const FavouriteState({this.status = FavouriteStatus.initial, this.dwelling});

  final FavouriteStatus status;
  final OneDwellingResponse? dwelling;

  FavouriteState copyWith(
      {FavouriteStatus? status, OneDwellingResponse? dwelling}) {
    return FavouriteState(
        status: status ?? this.status, dwelling: dwelling ?? this.dwelling);
  }

  @override
  String toString() {
    return '''FavouriteState { status: $status}''';
  }

  @override
  List<Object> get props => [status];
}
