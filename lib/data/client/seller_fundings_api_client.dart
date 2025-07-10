import 'dart:io';

import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/buyer/stores_endpoints.dart';
import 'package:on_woori/config/endpoint/seller/seller_funding_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/request/funding/create_funding_request.dart';
import 'package:on_woori/data/entity/request/funding/edit_funding_request.dart';
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

  Future<CreateFundingRequest> createFunding({
    required String storeId,
    required String title,
    String? linkUrl,
    String? imageUrl,
  }) async {
    final formData = FormData.fromMap({
      'storeId': storeId,
      'title': title,
      if (linkUrl != null && linkUrl.isNotEmpty) 'linkUrl': linkUrl,
      if (imageUrl != null && imageUrl.isNotEmpty) 'imageUrl': imageUrl,
    });

    final response = await _dio.post(
      SellerFundingEndpoints.getFunding,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return CreateFundingRequest.fromJson(response.data);
  }

  Future<SellerFundingResponse> fundingDetail({required String id})
  async {
    final response = await _dio.get(
      SellerFundingEndpoints.getFundingDetail(id: id),
    );
    return SellerFundingResponse.fromJson(response.data);
  }

  // 펀딩 수정
  Future<Response> editFundings({
    required String id,
    required String title,
    String? linkUrl,
    File? thumbnailImage,
  }) async {

    final formData = FormData.fromMap({
      'title': title,
      if (linkUrl != null && linkUrl.isNotEmpty) 'linkUrl': linkUrl,
    });

    if (thumbnailImage != null) {
      formData.files.add(MapEntry(
        'thumbnailImage',
        await MultipartFile.fromFile(
            thumbnailImage.path,
            filename: thumbnailImage.path.split('/').last
        ),
      ));
    }

    final response = await _dio.patch(
      SellerFundingEndpoints.editFunding(id: id),
      data: formData,
    );
    return response;
  }

  Future<ApiBasicResponse> deleteFunding({required String id}) async {
    final response = await _dio.delete(
      SellerFundingEndpoints.getFundingDetail(id: id),
      queryParameters: {'hard': true},
    );
    return ApiBasicResponse.fromJson(response.data);
  }

}
