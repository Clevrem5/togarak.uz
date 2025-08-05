import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/servise/secure_storage.dart';
import '../../../data/models/auth_models/user_model.dart';
import '../../../data/repositories/auth_repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository}) : _repository = repository, super(AuthInitial()) {
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
    on<GoogleSignInRequest>(_google);
  }

  Future<void> _onSignUpRequested(AuthSignUpRequested event, Emitter<AuthState> emit) async {
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

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await _repository.login(event.phone, event.password);
      print("xolati bloc : $success");
      if (success == true && _repository.jwt != null) {
        emit(AuthAuthenticated(_repository.jwt!));
      } else {
        emit(AuthError("Login yoki parol xato"));
      }
    } catch (e) {
      emit(AuthError("Xatolik: ${e.toString()}"));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _repository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final token = await SecureStorage.readToken();
    if (token != null) {
      emit(AuthAuthenticated(token));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _google(GoogleSignInRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Google Sign-In obyektini yaratish
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'profile',
        ],
        serverClientId: '636617091268-fduv9skas60e3caldd86ll5q960fhv5b.apps.googleusercontent.com', // O'zingizning client ID
      );

      // Sign In qilish
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthError("Google orqali kirish bekor qilindi"));
        return;
      }

      // Authentication token olish (agar kerak bo'lsa)
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // User ma'lumotlarini olish
      final String email = googleUser.email;
      final String givenName = googleUser.displayName?.split(" ").first ?? '';
      final String familyName = googleUser.displayName?.split(" ").last ?? '';
      final String deviceId = await DeviceUtils.getDeviceId();

      // Agar backend'ga Google ID token kerak bo'lsa
      final String? idToken = googleAuth.idToken;

      final user = UserModel(
        email: email,
        givenName: givenName,
        familyName: familyName,
        deviceId: idToken!,
      );

      final token = await _repository.registerGoogle(user);
      emit(AuthAuthenticated(token));
    } catch (e) {
      print(e.toString());
      emit(AuthError("Google Sign-In xatosi: ${e.toString()}"));
    }
  }
}

class DeviceUtils {
  static Future<String> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? 'unknown_android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown_ios';
      }
    } catch (e) {
      return 'unknown_device';
    }

    return 'unknown_platform';
  }
}
