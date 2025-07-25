import 'package:togarak/core/network/api_servise.dart';
import '../../../core/network/secure_storage.dart';
import '../../models/auth_models/auth_model.dart';

class AuthRepository {
  final ApiClient client;

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
        password: password!,
      ),
    );
  }

  Future<String> login(String login, String password) async {
    try {
      jwt = await client.login(login, password); // may throw!
      if (jwt == null) throw Exception('Token yo‘q');

      await SecureStorage.deleteCredentials();
      await SecureStorage.deleteToken();
      await SecureStorage.saveToken(jwt!);
      await SecureStorage.saveCredentials(login, password);

      return jwt!;
    } catch (e) {
      throw Exception('Login xatolik: $e');
    }
  }

  Future<void> logOut() async {
    await SecureStorage.deleteCredentials();
    await SecureStorage.deleteToken();
  }

  Future<bool> refreshToken() async {
    var credentials = await SecureStorage.getCredentials();
    final phone = credentials['phone'];
    final password = credentials['user_password'];

    if (phone == null || password == null) return false;
    jwt = await client.login(phone, password);
    print('Login token: $jwt');
    // await SecureStorage.deleteToken();
    await SecureStorage.saveToken(jwt!);
    return true;
  }
}
