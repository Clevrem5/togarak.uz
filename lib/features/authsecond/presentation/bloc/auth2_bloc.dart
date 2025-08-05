import 'package:bloc/bloc.dart';
import 'package:togarak/features/authsecond/domain/usecases/login_usecase.dart';
import 'package:togarak/features/authsecond/presentation/bloc/auth2_event.dart';
import 'package:togarak/features/authsecond/presentation/bloc/auth2_state.dart';

class AuthBloc2 extends Bloc<AuthEvent2, AuthState2> {
  final LoginUseCase loginUseCase;

  AuthBloc2({required this.loginUseCase}) : super(AuthInitial2()) {
    on<LoginSubmit>(_login);
  }

  Future<void> _login(LoginSubmit event, Emitter<AuthState2> emit) async {
    emit(AuthLoading2());
    try {
      final result = await loginUseCase(event.login, event.password);
      result.fold(
        (failure) => emit(AuthFailure2(failure.message)),
        (user) => AuthSuccess(user),
      );
    } catch (e) {
      emit(AuthFailure2(e.toString()));
    }
  }
}
