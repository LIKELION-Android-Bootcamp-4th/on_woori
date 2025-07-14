import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/stores_endpoints.dart';
import 'package:on_woori/config/endpoint/seller/seller_store_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/stores/stores_response.dart';

class StoresApiClient {
  final Dio _dio;

  StoresApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 공개 펀딩 목록 조회
  Future<StoresResponse> stores() async {
    final response = await _dio.get(StoresEndpoints.getStores);
    return StoresResponse.fromJson(response.data);
  }

  Future<StoreDetailResponse> storeDetail(String id) async {
    final response = await _dio.get(StoresEndpoints.getStoreDetail(id: id));
    return StoreDetailResponse.fromJson(response.data);
  }

  Future<StoreProductsResponse> storeProductList(String id) async {
    final response = await _dio.get(StoresEndpoints.getStoreProducts(id: id));
    return StoreProductsResponse.fromJson(response.data);
  }

  // 상점 정보 조회 & 변경
  Future<SellerStoreResponse> getSellerStore() async {
    final response = await _dio.get(
      SellerStoreEndpoints.getSellerStoresMystore,
    );
    return SellerStoreResponse.fromJson(response.data);
  }

  Future<SellerStoreResponse> editSellerStore({
    required String name,
    required String description,
    required SellerStoreData data,
    MultipartFile? image,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'description': description,
      'category': data.category,
      'status': data.status,
      'thumbnailImage': image ?? data.thumbnailImageUrl,
    });

    final response = await _dio.patch(
      SellerStoreEndpoints.patchSellerStoresMystore,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return SellerStoreResponse.fromJson(response.data);
  }
}
