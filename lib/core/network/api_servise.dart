import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:togarak/core/network/interseptor.dart';
import 'package:togarak/data/models/auth_models/auth_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.togarak.uz/services/platon-core/api",
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(AuthInterceptor());

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
        if (token == null) {
          throw Exception(" Access token topilmadi!");
        }
        return token;
      } else {
        throw Exception("❌ Noto‘g‘ri status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("⚠️ DioException caught!");
      print("🔢 Status code: ${e.response?.statusCode}");
      print("📨 Response data: ${e.response?.data}");
      throw Exception("Login xatoligi: ${e.response?.statusCode}");
    } catch (e) {
      print("🚨 Boshqa xatolik: $e");
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
}
