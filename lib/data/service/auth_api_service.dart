import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/auth_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/request/login_request.dart';

class AuthApiService {
  final Dio _dio;

  // 싱글톤, 의존성 주입
  AuthApiService() : _dio = ApiClient().dio;

  // 로그인 부터 구현
  Future<Map<String, dynamic>> authLogin({
    required LoginRequest request
  }) async {
    try {
      // 2. 요청 보내기
      final response = await _dio.post(
          AuthEndpoints.postAuthLogin,
          data: request
      );

      // 3. 응답 코드 확인하기
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("인증 실패 : " + response.toString());
      }
    }
    on DioException catch (e) {
      if(e.response != null) {
        throw Exception(e.response!.data + "서버가 응답하지 않습니다.");
      } else if (e.response?.statusCode == 401) {
        throw Exception("이메일 또는 비밀번호가 일치하지 않습니다.");
      }
      rethrow;
    } catch (e) {
      throw Exception("알 수 없는 에러 (로그인)");
    }
  }
}