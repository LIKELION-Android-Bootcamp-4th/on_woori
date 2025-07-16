import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/admin_product_endpoints.dart';
import 'package:on_woori/config/endpoint/auth_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/request/auth/login_request.dart';
import 'package:on_woori/data/entity/request/auth/register_buyer_request.dart';
import 'package:on_woori/data/entity/request/auth/register_seller_request.dart';
import 'package:on_woori/data/entity/request/auth/verify_email_request.dart';
import 'package:on_woori/data/entity/response/auth/login_response.dart';
import 'package:on_woori/data/entity/response/auth/logout_response.dart';
import 'package:on_woori/data/entity/response/auth/verify_email_response.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 로그인 (전체)
  Future<LoginResponse> authLogin({required LoginRequest request}) async {
    final response = await _dio.post(
      AuthEndpoints.postAuthLogin,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  // 판매자 회원가입
  Future<LoginResponse> authRegisterSeller({
    required RegisterSellerRequest request,
  }) async {
    final response = await _dio.post(
      AuthEndpoints.postAuthRegisterSeller,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  // 구매자 회원가입
  Future<LoginResponse> authRegisterBuyer({
    required RegisterBuyerRequest request,
  }) async {
    final response = await _dio.post(
      AuthEndpoints.postAuthRegisterBuyer,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  // 이메일 인증 코드 확인
  Future<VerifyEmailResponse> authVerifyEmail({
    required VerifyEmailRequest request,
  }) async {
    final response = await _dio.post(
      AuthEndpoints.postAuthVerifyEmail,
      data: request.toJson(),
    );
    return VerifyEmailResponse.fromJson(response.data);
  }

  // 로그아웃
  Future<LogoutResponse> authLogout() async {
    final response = await _dio.post(AuthEndpoints.postAuthLogout);
    return LogoutResponse.fromJson(response.data);
  }

  // 비밀번호 변경
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await _dio.patch(
      AdminProductEndpoints.changeAuthUserPassword(),
      data: {
        'isForceChange': false,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
    return response;
  }
}
