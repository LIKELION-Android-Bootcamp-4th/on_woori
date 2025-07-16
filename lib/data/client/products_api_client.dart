import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/admin_product_endpoints.dart';
import 'package:on_woori/config/endpoint/buyer/products_endpoints.dart';
import 'package:on_woori/config/endpoint/seller/seller_products_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/products/product_register_response.dart';
import 'package:on_woori/data/entity/response/products/product_toggle_response.dart';
import 'package:on_woori/data/entity/response/products/products_detail_response.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

class ProductsApiClient {
  final Dio _dio;

  ProductsApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 상품 목록 검색
  Future<ProductsResponse> products() async {
    final response = await _dio.get(ProductsEndpoints.getProducts);
    return ProductsResponse.fromJson(response.data);
  }

  // 판매자 상품 목록 조회
  Future<ProductsResponse> sellerProducts() async {
    final response = await _dio.get(SellerProductsEndpoints.getSellerProducts);
    return ProductsResponse.fromJson(response.data);
  }

  Future<ProductsDetailResponse> productDetail(String id) async {
    final response = await _dio.get(ProductsEndpoints.getProductDetail(id: id));
    return ProductsDetailResponse.fromJson(response.data);
  }

  Future<ProductRegisterResponse> productRegister(FormData formData) async {
    final response = await _dio.post(
      ProductsEndpoints.getProductRegister,
      data: formData,
    );
    return ProductRegisterResponse.fromJson(response.data);
  }

  // 상품 찜 토글 (추가 또는 삭제)
  Future<ProductToggleResponse> toggleFavorite({
    required String productId,
  }) async {
    final response = await _dio.post(
      ProductsEndpoints.postProductToggleFavorites(productId: productId),
    );
    return ProductToggleResponse.fromJson(response.data);
  }

  // 상품 수정
  Future<ProductRegisterResponse> productUpdate({
    required String id,
    required FormData formData,
  }) async {
    final response = await _dio.patch(
      ProductsEndpoints.patchProductUpdate(id: id),
      data: formData,
    );
    return ProductRegisterResponse.fromJson(response.data);
  }

  Future<Response> deleteProductForce({required String id}) async {
    final response = await _dio.delete(
      AdminProductEndpoints.deleteAdminProductsForce(id: id),
    );
    return response;
  }
}
