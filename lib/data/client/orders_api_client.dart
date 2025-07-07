import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/order_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/orders/order_detail_response.dart';
import 'package:on_woori/data/entity/response/orders/orders_response.dart';

class OrdersApiClient {
  final Dio _dio;

  OrdersApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 내 주문 목록 조회
  Future<OrdersResponse> getOrders()
  async {
    final response = await _dio.get(
      OrderEndpoints.getOrders,
    );
    return OrdersResponse.fromJson(response.data);
  }

  // 주문 상세 조회
  Future<OrderDetailResponse> getOrderDetail({
    required String orderId,
  })
  async {
    final response = await _dio.get(
      OrderEndpoints.getOrdersDetail(orderId: orderId),
    );
    return OrderDetailResponse.fromJson(response.data);
  }
}