import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/mypage_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/mypage/wish_response.dart';

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
}