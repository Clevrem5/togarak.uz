abstract class AuthEvent2 {}

class LoginSubmit extends AuthEvent2 {
  final String login;
  final String password;

  LoginSubmit(this.login, this.password);
}
