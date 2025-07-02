import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager extends Interceptor {
  final _storage = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. 저장된 토큰을 읽어옵니다.
    final token = await _storage.read(key: 'ACCESS_TOKEN');

    // 2. 토큰이 있다면, 헤더에 'Authorization'을 추가합니다.
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 3. 다음 로직으로 요청을 계속 진행시킵니다.
    super.onRequest(options, handler);
  }
}