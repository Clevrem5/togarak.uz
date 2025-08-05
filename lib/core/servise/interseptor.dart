import 'package:dio/dio.dart';
import 'package:togarak/core/exports.dart';
import '../../data/repositories/auth_repositories/auth_repository.dart';


class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorage.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }
}

@override
void onError(DioException err, ErrorInterceptorHandler handler) async {
  if (err.response?.statusCode == 401) {
    final _context = navigatorKey.currentContext;
    if (_context != null) {
      final result = await _context.read<AuthRepository>().refreshToken();

      if (result) {
        final newToken = await SecureStorage.readToken();

        final updatedRequest = err.requestOptions;
        updatedRequest.headers['Authorization'] = "Bearer $newToken";

        final response = await Dio().fetch(updatedRequest);
        return handler.resolve(response);
      } else {
        await _context.read<AuthRepository>().logout();
        _context.go(Routes.login);
        return handler.reject(err);
      }
    } else {
      return handler.reject(err);
    }
  } else {
    return handler.next(err);
  }
}
