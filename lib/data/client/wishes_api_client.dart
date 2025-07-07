

import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/products_favorites_endpoints.dart';

import '../api_client.dart';
import '../entity/response/mypage/wish_response.dart';

class WishesApiClient {
  final Dio _dio;

  WishesApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  Future<WishResponse> isFavorite(String productId)
  async {
    final response = await _dio.get(
      ProductsFavoritesEndpoints.getProductsFavorites(productId: productId),
    );
    return WishResponse.fromJson(response.data);
  }
  Future<WishResponse> getWishList()
  async {
    final response = await _dio.get(
      ProductsFavoritesEndpoints.getMyFavorites(),
    );
    return WishResponse.fromJson(response.data);
  }
}