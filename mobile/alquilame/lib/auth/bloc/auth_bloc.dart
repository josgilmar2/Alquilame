import 'package:alquilame/auth/auth.dart';
import 'package:alquilame/rest/rest.dart';
import 'package:alquilame/services/services.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final UserService _userService;

  AuthBloc(AuthService authService, UserService userService)
      : assert(authService != null),
        assert(userService != null),
        _authService = authService,
        _userService = userService,
        super(AuthInitial()) {
    on<AppLoaded>(_onAppLoaded);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UserLoggedOut>(_onUserLoggedOut);
    on<SessionExpiredEvent>(_onSessionExpired);
    on<UserDelete>(_onUserDelete);
  }

  _onAppLoaded(AppLoaded event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final currentUser = await _authService.getCurrentUser();

      if (currentUser != null) {
        emitter(AuthAuthenticated(user: currentUser));
      } else {
        emitter(AuthNotAuthenticated());
      }
    } on UnauthorizedException catch (e) {
      print(e);
      emitter(AuthNotAuthenticated());
    } on Exception catch (e) {
      emitter(AuthFailure(message: 'Ha ocurrido un error; ${e.toString()}'));
    }
  }

  _onUserLoggedIn(UserLoggedIn event, Emitter<AuthState> emitter) async {
    emitter(AuthAuthenticated(user: event.user));
  }

  _onUserLoggedOut(UserLoggedOut event, Emitter<AuthState> emitter) async {
    await _authService.signOut();
    emitter(AuthNotAuthenticated());
  }

  _onSessionExpired(
      SessionExpiredEvent event, Emitter<AuthState> emitter) async {
    print("Sesión expirada");
    await _authService.signOut();
    emitter(SessionExpiredState());
  }

  _onUserDelete(UserDelete event, Emitter<AuthState> emitter) async {
    try {
      await _userService.deleteProfile();
    } on Exception catch (e) {
      print(e);
    }
    await _authService.signOut();
    emitter(AuthNotAuthenticated());
  }
}
