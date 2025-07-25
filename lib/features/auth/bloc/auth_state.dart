import '../../../data/models/auth_models/auth_model.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState {
  final AuthStatus status;
  final AuthModel? model;
  final String? token;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.model,
    this.token,
    this.errorMessage,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    AuthModel? model,
    String? token,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      model: model ?? this.model,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthState &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              model == other.model &&
              token == other.token &&
              errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^ model.hashCode ^ token.hashCode ^ errorMessage.hashCode;
}
