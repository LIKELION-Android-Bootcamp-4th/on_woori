import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/mypage_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_response.dart';
import 'package:on_woori/data/entity/response/mypage/profile_response.dart';
import 'package:on_woori/data/entity/response/mypage/wish_response.dart';

import '../entity/request/mypage/mypage_request.dart';

class MypageApiClient {
  final Dio _dio;

  MypageApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 내 프로필 조회
  Future<ProfileResponse> getProfile() async {
    final response = await _dio.get(
      MyPageEndpoints.getMyPageProfile,
    );
    return ProfileResponse.fromJson(response.data);
  }

  Future<WishResponse> isFavorite(String productId)
  async {
    final response = await _dio.get(
      MyPageEndpoints.getMyPageFavorites,
    );
    return WishResponse.fromJson(response.data);
  }

  //프로필 정보 조회
  Future<BuyerProfileResponse> getBuyerProfile()
  async {
    final response = await _dio.get(
      MyPageEndpoints.getMyPageProfile
    );
    return BuyerProfileResponse.fromJson(response.data);
  }

  Future<void> editBuyerProfile({
    required String nickName,
    MultipartFile? profileImageFile,
    String? phone,
    AddressData? address,
  }) async {
    final formData = FormData.fromMap({
      'nickName': nickName,
      if (profileImageFile != null) 'profileImage': profileImageFile,
      if (phone != null) 'phone': phone,
      if (address != null) 'address' : address
    });

    final response = await _dio.patch(
      MyPageEndpoints.putMyPageProfile,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return response.data;
  }
}