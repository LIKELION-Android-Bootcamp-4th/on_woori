import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/seller/seller_upload_endpoints.dart';
import 'package:on_woori/data/api_client.dart'; // 기본 ApiClient (가정)
import 'package:on_woori/data/entity/request/upload/upload_files_request.dart';
import 'package:on_woori/data/entity/response/upload/upload_files_response.dart'; // 이전 단계에서 만든 요청 엔티티

class UploadApiClient {
  final Dio _dio;

  UploadApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  Future<UploadFilesResponse> uploadFiles(UploadFilesRequest request) async {
    final response = await _dio.post(
      SellerUploadEndpoints.postUploadFiles,
      data: await request.toFormData(),
    );
    return UploadFilesResponse.fromJson(response.data);
  }
}