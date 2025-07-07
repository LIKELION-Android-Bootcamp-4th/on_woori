import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/cart_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/request/cart/cart_request.dart';
import 'package:on_woori/data/entity/response/cart/cart_response.dart';

class CartApiClient {
  final Dio _dio;

  CartApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 내 장바구니 조회
  Future<CartResponse> getCart()
  async {
    final response = await _dio.get(
      CartEndpoints.getCart,
    );
    return CartResponse.fromJson(response.data);
  }

  // 장바구니에서 선택된 상품 제거
  Future<CartResponse> deleteCart( {
    required CartRequest request,
  }) async {
    final response = await _dio.delete(
      CartEndpoints.getCart,
      data: request.toJson(),
    );
    return CartResponse.fromJson(response.data);
  }
}