import 'package:togarak/data/models/auth_models/auth_model.dart';

sealed class AuthEvent {}

final class SignUpSubmitted extends AuthEvent {
  final AuthModel data;

  SignUpSubmitted({required this.data});
}

final class LoginSubmitted extends AuthEvent {
  final String phone;
  final String password;

  LoginSubmitted({required this.phone, required this.password});
}
