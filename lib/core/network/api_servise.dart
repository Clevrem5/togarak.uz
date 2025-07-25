import 'package:dio/dio.dart';
import 'package:togarak/core/network/interseptor.dart';
import 'package:togarak/core/network/secure_storage.dart';
import 'package:togarak/data/models/auth_models/auth_model.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://api.togarak.uz/services/platon-core/api",
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ) {
    dio.interceptors.add(AuthInterceptor());
  }

  Future<String> login(String phone, String password) async {
    final response = await dio.post(
      "/auth/v2/login",
      data: {
        "phone": phone,
        "user_password": password,
      },
    );

    print("Login javobi: ${response.data}");

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data as Map<String, dynamic>;
      final token = data['access_token']?.toString();
      await SecureStorage.saveToken(token!);
      return token;
    } else {
      throw Exception("Login xato");
    }
  }

  Future<bool> signUp(AuthModel model) async {
    final response = await dio.post(
      "/auth/v2/registration",
      data: model.toJson(),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
