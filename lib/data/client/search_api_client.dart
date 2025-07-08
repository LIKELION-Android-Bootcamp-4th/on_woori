import 'package:dio/dio.dart';
import 'package:on_woori/data/api_client.dart';
import '../../config/endpoint/buyer/search_endpoints.dart';

class SearchApiClient {
  final Dio _dio;

  String? _companyCode;
  String? _authToken;

  SearchApiClient() : _dio = ApiClient().dio;

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

    if (_companyCode != null && _companyCode!.isNotEmpty) {
      headers['X-Company-Code'] = _companyCode!;
    }

    if (_authToken != null && _authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  Future<Response> searchByCategory({
    required String category,
    required String query,
  }) async {
    final customHeaders = _buildHeaders();
    final queryParams = {
      'q': query,
    };

    print('🟢 [searchByCategory] 요청');
    print('🔹 category: $category');
    print('🔹 query: $query');
    print('🔹 customHeaders: $customHeaders');
    print('🔹 queryParameters: $queryParams');

    return await _dio.get(
      SearchEndpoints.byCategory(category),
      queryParameters: queryParams,
      options: Options(
        headers: {
          ..._dio.options.headers,
          ...customHeaders,
        },
      ),
    );
  }
}
