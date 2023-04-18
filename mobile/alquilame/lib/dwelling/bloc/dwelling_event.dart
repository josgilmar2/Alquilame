import 'package:equatable/equatable.dart';

abstract class DwellingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DwellingFetched extends DwellingEvent {}

class DwellingRefresh extends DwellingEvent {}

class DwellingUserFetched extends DwellingEvent {}

class DwellingDelete extends DwellingEvent {
  final int id;

  DwellingDelete({required this.id});

  @override
  List<Object> get props => [id];
}
