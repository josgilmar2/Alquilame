import 'package:alquilame/models/models.dart';
import 'package:equatable/equatable.dart';

enum DwellingStatus { initial, success, failure, delete }

class DwellingState extends Equatable {
  const DwellingState(
      {this.status = DwellingStatus.initial,
      this.dwellings = const <Dwelling>[],
      this.hasReachedMax = false,
      this.page = 0});

  final DwellingStatus status;
  final List<Dwelling> dwellings;
  final bool hasReachedMax;
  final int page;

  DwellingState copyWith(
      {DwellingStatus? status,
      List<Dwelling>? dwellings,
      bool? hasReachedMax,
      int? page}) {
    return DwellingState(
        status: status ?? this.status,
        dwellings: dwellings ?? this.dwellings,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page);
  }

  @override
  String toString() {
    return '''DwellingState { status: $status, hasReachedMax: $hasReachedMax, posts: ${dwellings.length} }''';
  }

  @override
  List<Object> get props => [status, dwellings, hasReachedMax, page];
}
