import 'package:alquilame/home/home.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final UserResponse user;

  UserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthEvent {}

class SessionExpiredEvent extends AuthEvent {}

class UserDelete extends AuthEvent {}
