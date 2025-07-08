import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/products_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/products/products_detail_response.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

class ProductsApiClient {
  final Dio _dio;

  ProductsApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 상품 목록 검색
  Future<ProductsResponse> products()
  async {
    final response = await _dio.get(
      ProductsEndpoints.getProducts,
    );
    return ProductsResponse.fromJson(response.data);
  }

  Future<ProductsDetailResponse> productDetail(String id)
  async {
    final response = await _dio.get(
      ProductsEndpoints.getProductDetail(id: id),
    );
    return ProductsDetailResponse.fromJson(response.data);
  }
}