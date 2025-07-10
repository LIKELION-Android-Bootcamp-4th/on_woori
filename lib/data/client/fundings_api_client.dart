import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/auth_endpoints.dart';
import 'package:on_woori/config/endpoint/buyer/fundings_endpoints.dart';
import 'package:on_woori/config/endpoint/buyer/products_endpoints.dart';
import 'package:on_woori/config/endpoint/seller/seller_funding_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/request/auth/login_request.dart';
import 'package:on_woori/data/entity/request/auth/register_buyer_request.dart';
import 'package:on_woori/data/entity/request/auth/register_seller_request.dart';
import 'package:on_woori/data/entity/request/auth/verify_email_request.dart';
import 'package:on_woori/data/entity/request/funding/edit_funding_request.dart';
import 'package:on_woori/data/entity/response/auth/login_response.dart';
import 'package:on_woori/data/entity/response/auth/register_response.dart';
import 'package:on_woori/data/entity/response/auth/verify_email_response.dart';
import 'package:on_woori/data/entity/response/fundings/funding_detail_response.dart';
import 'package:on_woori/data/entity/response/fundings/fundings_response.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

class FundingsApiClient {
  final Dio _dio;

  FundingsApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 공개 펀딩 목록 조회
  Future<FundingsResponse> fundings()
  async {
    final response = await _dio.get(
      FundingsEndpoints.getFundings,
    );
    return FundingsResponse.fromJson(response.data);
  }

  Future<FundingDetailResponse> fundingDetail({required String id}) async {
    final response = await _dio.get(
      FundingsEndpoints.getFundingsDetail(fundingId: id),
    );
    // Dio Response 대신 직접 파싱한 객체를 반환
    return FundingDetailResponse.fromJson(response.data);
  }
}