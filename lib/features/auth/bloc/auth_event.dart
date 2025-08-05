import '../../../data/models/auth_models/auth_model.dart';

abstract class AuthEvent {}

class AuthSignUpRequested extends AuthEvent {
  final AuthModel authModel;

  AuthSignUpRequested(this.authModel);
}

class AuthLoginRequested extends AuthEvent {
  final String phone;
  final String password;

  AuthLoginRequested(this.phone, this.password);
}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}


class GoogleSignInRequest extends AuthEvent{}