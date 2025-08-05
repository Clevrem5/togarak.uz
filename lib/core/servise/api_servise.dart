import 'package:togarak/core/exports.dart';

import 'interseptor.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.togarak.uz/services/platon-core/api",
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(AuthInterceptor());

  Future<Response> post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  Future<String> login(String login, String password) async {
    try {
      final response = await _dio.post(
        '/auth/v2/login',
        data: {
          "phone": login,
          "user_password": password,
        },
      );
      if (kDebugMode) {
        debugPrint("📡 Response status: ${response.statusCode}");
        debugPrint("📦 Response data: ${response.data}");
      }

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data["data"]?["result"]?["data"]?["access_token"];
        print("token : $token");
        if (token == null) {
          throw Exception(" Access token topilmadi!");
        }
        return token;
      } else {
        throw Exception("❌ Noto‘g‘ri status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Login xatoligi: ${e.response?.statusCode}");
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(AuthModel model) async {
    final response = await _dio.post(
      "/auth/v2/registration",
      data: model.toJson(),
    );
    return response.statusCode == 200 || response.statusCode == 201 ? true : false;
  }

  Future<String> registerWithEmail(Map<String, dynamic> params) async {
    final response = await _dio.post(
      "/auth/v2/registration/email",
      queryParameters: params,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      final token = data["data"]?["result"]?["data"]?["access_token"];
      if (token == null) {
        throw Exception(" Access token topilmadi!");
      }
      return token;
    } else {
      throw Exception("❌ Noto‘g‘ri status code: ${response.statusCode}");
    }
  }
}
