import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/mypage_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_profile_response.dart';

class MypageApiClient {
  final Dio _dio;

  MypageApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 내 프로필 조회
  Future<MyPageProfileResponse> myPageProfile() async {
    final response = await _dio.get(
      MyPageEndpoints.getMyPageProfile,
    );
    return response.data;
  }

}