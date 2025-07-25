import 'package:bloc/bloc.dart';
import 'package:togarak/data/repositories/auth_repositories/auth_repository.dart';
import 'package:togarak/features/auth/bloc/auth_event.dart';
import 'package:togarak/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repo})
    : _repository = repo,
      super(
        AuthState.initial(),
      ) {
    on<SignUpSubmitted>(_signUp);
    on<LoginSubmitted>(_login);
  }

  Future<void> _login(LoginSubmitted event, Emitter<AuthState> emit) async {
    try {
      final user = await _repository.login(event.phone, event.password);
      emit(
        state.copyWith(
          status: AuthStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
        ),
      );
    }
  }

  Future<void> _signUp(SignUpSubmitted event, Emitter<AuthState> emit) async {
    try {
      final user = await _repository.signUp(
        firstname: event.data.name,
        lastName: event.data.surname,
        phone: event.data.phone,
        password: event.data.password,
      );
      if (user) {
        emit(
          state.copyWith(
            status: AuthStatus.success,
            model: event.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.error,
          ),
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
