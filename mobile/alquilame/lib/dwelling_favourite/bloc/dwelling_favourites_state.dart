import 'package:alquilame/models/models.dart';
import 'package:equatable/equatable.dart';

enum DwellingFavouritesStatus { initial, success, failure }

class DwellingFavouritesState extends Equatable {
  const DwellingFavouritesState({
    this.status = DwellingFavouritesStatus.initial,
    this.dwellings = const <Dwelling>[],
    this.hasReachedMax = false,
  });

  final DwellingFavouritesStatus status;
  final List<Dwelling> dwellings;
  final bool hasReachedMax;

  DwellingFavouritesState copyWith({
    DwellingFavouritesStatus? status,
    List<Dwelling>? dwellings,
    bool? hasReachedMax,
  }) {
    return DwellingFavouritesState(
      status: status ?? this.status,
      dwellings: dwellings ?? this.dwellings,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''DwellingFavouritesState { status: $status, hasReachedMax: $hasReachedMax, posts: ${dwellings.length} }''';
  }

  @override
  List<Object> get props => [status, dwellings, hasReachedMax];
}
