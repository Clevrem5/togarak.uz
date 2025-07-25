import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String _tokenKey = "access_token";
  static const String _passwordKey = "user_password";
  static const String _emailKey = "email";
  static const String _codeKey = "code";
  static const String _name = "name";
  static const String _lastName = "surname";
  static const String _phoneNumber = "phone";
  static const _storage = FlutterSecureStorage();

  // Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }


  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    print("Access token: $token");
    return token;
  }


  static Future<void> deleteToken() async =>
      await _storage.delete(key: _tokenKey);

  // Credentials (phone + password)
  static Future<void> saveCredentials(String phone, String password) async {
    await _storage.write(key: _phoneNumber, value: phone);
    await _storage.write(key: _passwordKey, value: password);
  }

  static Future<Map<String, String?>> getCredentials() async {
    return {
      "phone": await _storage.read(key: _phoneNumber),
      "user_password": await _storage.read(key: _passwordKey),
    };
  }

  static Future<void> deleteCredentials() async {
    await _storage.delete(key: _phoneNumber);
    await _storage.delete(key: _passwordKey);
  }

  // Email
  static Future<void> saveEmail(String email) async =>
      await _storage.write(key: _emailKey, value: email);

  static Future<void> deleteEmail() async =>
      await _storage.delete(key: _emailKey);

  static Future<String?> getEmail() async =>
      await _storage.read(key: _emailKey);

  // Code
  static Future<void> saveCode(String code) async =>
      await _storage.write(key: _codeKey, value: code);

  static Future<void> deleteCode() async =>
      await _storage.delete(key: _codeKey);

  static Future<String?> getCode() async =>
      await _storage.read(key: _codeKey);

  // First Name
  static Future<void> saveFirstName(String firstName) async =>
      await _storage.write(key: _name, value: firstName);

  static Future<void> deleteFirstName() async =>
      await _storage.delete(key: _name);

  static Future<String?> getFirstName() async =>
      await _storage.read(key: _name);

  // Last Name
  static Future<void> saveLastName(String lastName) async =>
      await _storage.write(key: _lastName, value: lastName);

  static Future<void> deleteLastName() async =>
      await _storage.delete(key: _lastName);

  static Future<String?> getLastName() async =>
      await _storage.read(key: _lastName);

  // Phone Number
  static Future<void> savePhoneNumber(String phoneNumber) async =>
      await _storage.write(key: _phoneNumber, value: phoneNumber);

  static Future<void> deletePhoneNumber() async =>
      await _storage.delete(key: _phoneNumber);

  static Future<String?> getPhoneNumber() async =>
      await _storage.read(key: _phoneNumber);
}
