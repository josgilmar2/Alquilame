import 'package:alquilame/auth/auth.dart';
import 'package:alquilame/login/login.dart';
import 'package:alquilame/rest/rest.dart';
import 'package:alquilame/services/services.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final AuthService _authService;

  LoginBloc(AuthBloc authBloc, AuthService authService)
      : assert(authBloc != null),
        assert(authService != null),
        _authBloc = authBloc,
        _authService = authService,
        super(LoginInitial()) {
    on<LoginWithUsernameButtonPressed>(_onLoginWithUsernameButtonPressed);
  }

  _onLoginWithUsernameButtonPressed(
      LoginWithUsernameButtonPressed event, Emitter<LoginState> emitter) async {
    emitter(LoginLoading());
    try {
      final user = await _authService.signInWithUsernameAndPassword(
          event.username, event.password);
      if (user != null) {
        _authBloc.add(UserLoggedIn(user: user));
        emitter(LoginSuccess());
        emitter(LoginInitial());
      } else {
        emitter(LoginFailure(error: 'Ha pasado algo muy raro :S'));
      }
    } on AuthenticationException catch (e) {
      emitter(LoginFailure(error: e.message));
    } on CustomException catch (err) {
      emitter(
          LoginFailure(error: 'Un error desconocido ocurrió ${err.message}'));
    }
  }
}
