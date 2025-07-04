import 'package:dio/dio.dart';
import 'package:on_woori/data/token_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio dio;

  // 싱글톤 패턴으로 구현
  ApiClient._privateConstructor() : dio = Dio() {
    dio.options = BaseOptions(
      baseUrl: 'http://git.hansul.kr:3000/',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type' : 'application/json',
        'X-Company-Code' : '685f69fc439922c09c21aef0'
      }
    );

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