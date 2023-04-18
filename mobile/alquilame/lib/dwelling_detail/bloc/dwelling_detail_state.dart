import 'package:alquilame/models/models.dart';
import 'package:equatable/equatable.dart';

enum DwellingDetailStatus { initial, success, failure }

class DwellingDetailState extends Equatable {
  const DwellingDetailState(
      {this.status = DwellingDetailStatus.initial, this.dwellingDetail});

  final DwellingDetailStatus status;
  final OneDwellingResponse? dwellingDetail;

  DwellingDetailState copyWith(
      {DwellingDetailStatus? status, OneDwellingResponse? dwellingDetail}) {
    return DwellingDetailState(
        status: status ?? this.status,
        dwellingDetail: dwellingDetail ?? this.dwellingDetail);
  }

  @override
  String toString() {
    return '''DwellingState { status: $status}''';
  }

  @override
  List<Object> get props => [status];
}
