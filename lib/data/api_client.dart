import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:on_woori/data/token_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio dio;
  final _secureStorage = const FlutterSecureStorage();

  ApiClient._privateConstructor() : dio = Dio() {
    dio.options = BaseOptions(
      baseUrl: 'http://git.hansul.kr:3002/',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // companyId 읽어서 헤더에 추가
        final companyId = await _secureStorage.read(key: 'companyId');
        if (companyId != null) {
          options.headers['X-Company-Code'] = companyId;
        }

        // tokenManager로 추가 처리
        return handler.next(options);
      },
    ));

    dio.interceptors.add(TokenManager());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  static final ApiClient _instance = ApiClient._privateConstructor();

  factory ApiClient() {
    return _instance;
  }
}
