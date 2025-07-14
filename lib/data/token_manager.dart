import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager extends Interceptor {
  final _storage = const FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. 저장된 토큰을 읽어옵니다.
    final token = await _storage.read(key: 'ACCESS_TOKEN');
    final companyCode = await _storage.read(key: 'COMPANY_CODE');

    // 2. 토큰이 있으면 Authorization 헤더 추가
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 3. companyCode가 있으면 X-Company-Code 헤더 추가
    if (companyCode != null && companyCode.isNotEmpty) {
      options.headers['X-Company-Code'] = companyCode;
    }

    // 4. 요청 진행
    super.onRequest(options, handler);
  }
}
