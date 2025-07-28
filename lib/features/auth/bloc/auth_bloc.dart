import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/secure_storage.dart';
import '../../../data/repositories/auth_repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository}) :_repository=repository, super(AuthInitial()) {
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
  }

  Future<void> _onSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await _repository.signUp(
        firstname: event.authModel.name,
        lastName: event.authModel.surname,
        phone: event.authModel.phone,
        password: event.authModel.password,
      );
      if (success) {
        emit(AuthUnauthenticated());
      } else {
        emit(AuthError("Ro'yxatdan o'tishda xatolik yuz berdi"));
      }
    } catch (e) {
      emit(AuthError("Xatolik: ${e.toString()}"));
    }
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await _repository.login(event.phone, event.password);

      if (success) {
        if(success==true){
          emit(AuthAuthenticated(_repository.jwt!));
        }else if(_repository.jwt != null){
          emit(AuthAuthenticated(_repository.jwt!));
        }

      } else {
        emit(AuthError("Login yoki parol xato"));
      }
    } catch (e) {
      emit(AuthError("Xatolik: ${e.toString()}"));
    }
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _repository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckStatus(
      AuthCheckStatus event, Emitter<AuthState> emit) async {
    final hasToken = await SecureStorage.readToken();
    if (hasToken != null) {
      emit(AuthAuthenticated(hasToken));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
