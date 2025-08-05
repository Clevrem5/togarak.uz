import 'package:togarak/core/servise/api_servise.dart';
import 'package:togarak/data/models/auth_models/user_model.dart';

import '../../../core/servise/secure_storage.dart';
import '../../models/auth_models/auth_model.dart';

class AuthRepository {
  final ApiService client;

  AuthRepository({required this.client});

  String? jwt;

  Future<bool> signUp({
    String? firstname,
    String? lastName,
    String? phone,
    String? password,
  }) async {
    return await client.signUp(
      AuthModel(
        name: firstname,
        surname: lastName,
        phone: phone,
        password: password,
      ),
    );
  }

  Future<bool> login(String login, String password) async {
    await SecureStorage.deleteToken();
    await SecureStorage.deleteCredentials();
    print("xolati repo ");
    try {
      print("xolati fsfsdfs");
      final token = await client.login(login, password);
      jwt = token;
      await SecureStorage.saveToken(jwt!);
      await SecureStorage.saveCredentials(login, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> registerGoogle(UserModel user) async {
    final token = await client.registerWithEmail(user.toQuery());
    await SecureStorage.saveToken(token);
    return token;
  }

  Future<void> logout() async {
    await SecureStorage.deleteToken();
    await SecureStorage.deleteCredentials();
  }

  Future<bool> refreshToken() async {
    final credentials = await SecureStorage.getCredentials();
    if (credentials['login'] == null || credentials['password'] == null) {
      return false;
    }

    try {
      jwt = await client.login(credentials['login']!, credentials['password']!);
      await SecureStorage.saveToken(jwt!);
      return true;
    } catch (e) {
      return false;
    }
  }
}
