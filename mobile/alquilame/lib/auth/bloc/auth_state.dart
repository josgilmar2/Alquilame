import 'package:alquilame/home/home.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthNotAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserResponse user;

  AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class SessionExpiredState extends AuthFailure {
  SessionExpiredState()
      : super(message: 'La sesión ha expirado. Logueate de nuevo.');

  String get message => super.message;

  @override
  List<Object> get props => [message];
}
