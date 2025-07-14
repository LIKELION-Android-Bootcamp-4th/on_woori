import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/seller/seller_funding_endpoints.dart';
import 'package:on_woori/config/endpoint/seller/seller_store_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/seller/fundings/seller_funding_response.dart';
import 'package:on_woori/data/entity/response/seller/seller_store_response.dart';

class SellerStoreApi {
  final Dio _dio;

  SellerStoreApi({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  Future<SellerStoreResponse> getStore() async {
    final response = await _dio.get(
      SellerStoreEndpoints.getSellerStoresMystore,
    );
    return SellerStoreResponse.fromJson(response.data);
  }

  // 수정 해야 함
  Future<SellerFundingResponse> updateStore({required String id}) async {
    final response = await _dio.patch(
      SellerFundingEndpoints.getFundingDetail(id: id),
    );
    return SellerFundingResponse.fromJson(response.data);
  }
}
