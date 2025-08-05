import 'package:togarak/features/authsecond/domain/entities/user_enetity.dart';

abstract class AuthState2 {}

class AuthLoading2 extends AuthState2 {}

class AuthInitial2 extends AuthState2 {}

class AuthFailure2 extends AuthState2 {
  final String message;
  AuthFailure2(this.message);
}

class AuthSuccess extends AuthState2 {
  final UserEntity user;

  AuthSuccess(this.user);
}
