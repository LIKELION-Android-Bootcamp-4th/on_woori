import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/cart_endpoints.dart';
import 'package:on_woori/config/endpoint/buyer/fundings_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/cart/cart_response.dart';
import 'package:on_woori/data/entity/response/fundings/fundings_response.dart';

class CartApiClient {
  final Dio _dio;

  CartApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 내 장바구니 조회
  Future<CartResponse> cart()
  async {
    final response = await _dio.get(
      CartEndpoints.getCart,
    );
    return CartResponse.fromJson(response.data);
  }

}