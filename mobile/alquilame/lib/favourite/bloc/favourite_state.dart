import 'package:alquilame/models/models.dart';
import 'package:equatable/equatable.dart';

enum FavouriteStatus { initial, success, failure }

class FavouriteState extends Equatable {
  const FavouriteState(
      {this.status = FavouriteStatus.initial,
      this.dwelling,
      this.isFavourite = false,
      this.dwellings = const <Dwelling>[],
      this.hasReachedMax = false});

  final FavouriteStatus status;
  final OneDwellingResponse? dwelling;
  final bool isFavourite;
  final List<Dwelling> dwellings;
  final bool hasReachedMax;

  FavouriteState copyWith({
    FavouriteStatus? status,
    OneDwellingResponse? dwelling,
    bool? isFavourite,
    List<Dwelling>? dwellings,
    bool? hasReachedMax,
  }) {
    return FavouriteState(
        status: status ?? this.status,
        dwelling: dwelling ?? this.dwelling,
        isFavourite: isFavourite ?? this.isFavourite,
        dwellings: dwellings ?? this.dwellings,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return '''FavouriteState { status: $status}''';
  }

  @override
  List<Object> get props => [status];
}
