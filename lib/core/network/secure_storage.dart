import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'token';
  static const _loginKey = 'login';
  static const _passwordKey = 'password';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    print("Token o'chirildi");
  }

  static Future<void> saveCredentials(String login, String password) async {
    await _storage.write(key: _loginKey, value: login);
    await _storage.write(key: _passwordKey, value: password);
  }

  static Future<void> deleteCredentials() async {
    await _storage.delete(key: _loginKey);
    await _storage.delete(key: _passwordKey);
    print("Login va parol o'chirildi");
  }

  static Future<String?> readToken() async {
    return await _storage.read(key: _tokenKey);
  } static Future<Map<String, String?>> getCredentials() async {
    final login = await _storage.read(key: _loginKey);
    final password = await _storage.read(key: _passwordKey);
    return {
      'login': login,
      'password': password,
    };
  }




}


