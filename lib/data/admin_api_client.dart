import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:on_woori/config/endpoint/admin_product_endpoints.dart';
import 'package:on_woori/config/endpoint/auth_endpoints.dart';
import 'package:on_woori/data/entity/response/auth/login_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AdminApiClient {
  final _secureStorage = const FlutterSecureStorage();
  late final Dio _adminDio;
  final baseUrl = 'http://git.hansul.kr:3002';
  AdminApiClient() {
    _adminDio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    _adminDio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final adminToken = await _secureStorage.read(key: 'adminAccessToken');
        if (adminToken != null) {
          options.headers['Authorization'] = 'Bearer $adminToken';
        }
        options.headers['X-Company-Code'] = '6866fd115b230f5dc709bdef';
        return handler.next(options);
      },
    ));

    _adminDio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
  }

  Future<bool> loginAsAdmin() async {
    final loginDio = Dio(BaseOptions(baseUrl: baseUrl));
    try {
      final response = await loginDio.post(
          AuthEndpoints.postAuthLogin,
          data: {
            'email': 'admin@hanbokmall.com',
            'password': 'qwer1234'
          },
          options: Options(
              headers: {
                'X-Company-Code': '6866fd115b230f5dc709bdef'
              }
          )
      );
      final loginResponse = LoginResponse.fromJson(response.data);

      if (loginResponse.success && loginResponse.data != null) {
        await _secureStorage.write(
          key: 'adminAccessToken',
          value: loginResponse.data!.accessToken,
        );
        await _secureStorage.write(
          key: 'adminRefreshToken',
          value: loginResponse.data!.refreshToken,
        );
        print('관리자 로그인 성공. 별도의 키로 토큰을 저장했습니다.');
        return true;
      } else {
        print('관리자 로그인 실패: ${loginResponse.message}');
        return false;
      }
    } catch (e) {
      print('관리자 로그인 중 예외 발생: $e');
      return false;
    }
  }

  Future<Response> deleteProductForce({
    required String id,
  }) async {
    final response = await _adminDio.delete(
      AdminProductEndpoints.deleteAdminProductsForce(id: id),
    );
    return response;
  }

  Future<Response> changePassword({
    required String id,
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await _adminDio.patch(
      AdminProductEndpoints.changeAuthUserPassword(userId: id),
      data: {
        'isForceChange': false,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
    return response;
  }
}