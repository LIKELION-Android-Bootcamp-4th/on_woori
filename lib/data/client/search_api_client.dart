import 'package:dio/dio.dart';
import '../../config/endpoint/buyer/search_endpoints.dart';

class SearchApiClient {
  final Dio _dio;

  String? _companyCode;
  String? _authToken;

  SearchApiClient()
      : _dio = Dio(BaseOptions(
    baseUrl: 'http://git.hansul.kr:3000',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // 로그인 후 한 번만 호출
  void setAuthHeaders({
    required String companyCode,
    String? authToken,
  }) {
    _companyCode = companyCode;
    _authToken = authToken;
  }

  Map<String, String> _buildHeaders() {
    final headers = <String, String>{};

    /// TODO: 회사 코드가 없으면 테스트용 코드 주입 (주석처리하면 실제 환경)
    headers['X-Company-Code'] = _companyCode ?? '685f69fc439922c09c21aef0'; // 테스트 서버용 코드

    if (_authToken != null && _authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }


  Future<Response> searchByCategory({
    required String category,
    required String query,
  }) {
    return _dio.get(
      SearchEndpoints.byCategory(category),
      queryParameters: {
        'q': query,
      },
      options: Options(headers: _buildHeaders()),
    );
  }
}
