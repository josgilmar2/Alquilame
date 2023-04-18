import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginWithUsernameButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginWithUsernameButtonPressed(
      {required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
