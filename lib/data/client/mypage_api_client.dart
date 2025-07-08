import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/mypage_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_response.dart';
import 'package:on_woori/data/entity/response/mypage/wish_response.dart';

import '../entity/request/mypage/mypage_request.dart';

class MypageApiClient {
  final Dio _dio;

  MypageApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

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

  //프로필 수정
  Future<BuyerProfileEditResponse> editBuyerProfile({
    required BuyerProfileEditRequest request,
  })
  async {
    final response = await _dio.patch(
      MyPageEndpoints.putMyPageProfile,
      data: request.toJson(),
    );
    return BuyerProfileEditResponse.fromJson(response.data);
  }
}