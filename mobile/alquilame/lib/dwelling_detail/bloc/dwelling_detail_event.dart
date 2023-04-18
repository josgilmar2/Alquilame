import 'package:equatable/equatable.dart';

abstract class DwellingDetailEvent extends Equatable {
  const DwellingDetailEvent();

  @override
  List<Object> get props => [];
}

class DwellingDetailFetched extends DwellingDetailEvent {
  const DwellingDetailFetched(this.id);

  final int id;
}
