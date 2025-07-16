import 'dart:io';

import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/seller/seller_funding_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/request/funding/create_funding_request.dart';
import 'package:on_woori/data/entity/response/seller/fundings/seller_funding_response.dart';

import '../entity/response/ApiBasicResponse.dart';

class SellerFundingsApiClient {
  final Dio _dio;

  SellerFundingsApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 판매자 펀딩 목록 조회
  Future<SellerFundingResponse> sellerFunding() async {
    final response = await _dio.get(SellerFundingEndpoints.getFunding);
    return SellerFundingResponse.fromJson(response.data);
  }

  Future<CreateFundingRequest> createFunding({
    required String title,
    // String storeId,
    String? linkUrl,
    String? imageUrl,
  }) async {
    final FormData formData = FormData.fromMap(<String, dynamic>{
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

  Future<SellerFundingResponse> fundingDetail({required String id}) async {
    final response = await _dio.get(
      SellerFundingEndpoints.getFundingDetail(id: id),
    );
    return SellerFundingResponse.fromJson(response.data);
  }

  Future<Response> editFundings({
    required String id,
    required String title,
    String? linkUrl,
    File? thumbnailImage,
    bool deleteThumbnail = false, // 이미지 삭제 여부 플래그 추가
  }) async {
    final formData = FormData.fromMap({
      'title': title,
      if (linkUrl != null && linkUrl.isNotEmpty) 'linkUrl': linkUrl,
      // deleteThumbnail이 true이면, 'thumbnailImage' 필드에 null 값을 명시적으로 전송
      if (deleteThumbnail) 'thumbnailImage': null,
    });

    // 새 이미지가 있고, 삭제 플래그가 false일 때만 파일을 추가
    if (thumbnailImage != null && !deleteThumbnail) {
      formData.files.add(
        MapEntry(
          'thumbnailImage',
          await MultipartFile.fromFile(
            thumbnailImage.path,
            filename: thumbnailImage.path.split('/').last,
          ),
        ),
      );
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
