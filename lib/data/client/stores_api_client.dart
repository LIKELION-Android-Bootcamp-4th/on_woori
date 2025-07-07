import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/stores_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/stores/stores_response.dart';

class StoresApiClient {
  final Dio _dio;

  StoresApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 공개 펀딩 목록 조회
  Future<StoresResponse> stores()
  async {
    final response = await _dio.get(
      StoresEndpoints.getStores,
    );
    return StoresResponse.fromJson(response.data);
  }

  Future<StoreDetailResponse> storeDetail(String id)
  async {
    final response = await _dio.get(
      StoresEndpoints.getStoreDetail(id: id),
    );
    return StoreDetailResponse.fromJson(response.data);
  }

  Future<StoreProductsResponse> storeProductList(String id)
  async {
    final response = await _dio.get(
      StoresEndpoints.getStoreProducts(id: id),
    );
    return StoreProductsResponse.fromJson(response.data);
  }
}