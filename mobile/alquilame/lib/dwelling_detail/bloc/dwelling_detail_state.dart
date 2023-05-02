import 'package:alquilame/models/models.dart';
import 'package:equatable/equatable.dart';

enum DwellingDetailStatus { initial, success, failure }

class DwellingDetailState extends Equatable {
  const DwellingDetailState(
      {this.status = DwellingDetailStatus.initial,
      this.dwellingDetail,
      this.userResponse});

  final DwellingDetailStatus status;
  final OneDwellingResponse? dwellingDetail;
  final UserResponse? userResponse;

  DwellingDetailState copyWith(
      {DwellingDetailStatus? status,
      OneDwellingResponse? dwellingDetail,
      UserResponse? userResponse}) {
    return DwellingDetailState(
        status: status ?? this.status,
        dwellingDetail: dwellingDetail ?? this.dwellingDetail,
        userResponse: userResponse ?? this.userResponse);
  }

  @override
  String toString() {
    return '''DwellingState { status: $status}''';
  }

  @override
  List<Object> get props => [status];
}
