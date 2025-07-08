import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/stores_endpoints.dart';
import 'package:on_woori/config/endpoint/seller/seller_funding_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/response/seller/fundings/seller_funding_response.dart';
import 'package:on_woori/data/entity/response/stores/stores_response.dart';

import '../entity/response/ApiBasicResponse.dart';

class SellerFundingsApiClient {
  final Dio _dio;

  SellerFundingsApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 판매자 펀딩 목록 조회
  Future<SellerFundingResponse> sellerFunding()
  async {
    final response = await _dio.get(
      SellerFundingEndpoints.getFunding,
    );
    return SellerFundingResponse.fromJson(response.data);
  }

  Future<SellerFundingResponse> createFunding()
  async {
    final response = await _dio.post(
      SellerFundingEndpoints.getFunding,
    );
    return SellerFundingResponse.fromJson(response.data);
  }

  Future<SellerFundingResponse> fundingDetail({required String id})
  async {
    final response = await _dio.get(
      SellerFundingEndpoints.getFundingDetail(id: id),
    );
    return SellerFundingResponse.fromJson(response.data);
  }

  Future<SellerFundingResponse> updateFunding({required String id})
  async {
    final response = await _dio.patch(
      SellerFundingEndpoints.getFundingDetail(id: id),
    );
    return SellerFundingResponse.fromJson(response.data);
  }

  Future<ApiBasicResponse> deleteFunding({required String id}) async {
    final response = await _dio.delete(
      SellerFundingEndpoints.getFundingDetail(id: id),
      queryParameters: {'hard': true},
    );
    return ApiBasicResponse.fromJson(response.data);
  }

}
