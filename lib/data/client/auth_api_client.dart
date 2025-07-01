import 'package:dio/dio.dart';
import 'package:on_woori/config/endpoint/auth_endpoints.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/entity/request/login_request.dart';
import 'package:on_woori/data/entity/request/register_buyer_request.dart';
import 'package:on_woori/data/entity/request/register_seller_request.dart';
import 'package:on_woori/data/entity/request/verify_email_request.dart';
import 'package:on_woori/data/entity/response/login_response.dart';
import 'package:on_woori/data/entity/response/register_response.dart';
import 'package:on_woori/data/entity/response/verify_email_response.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  // 로그인 (전체)
  Future<LoginResponse> authLogin({
    required LoginRequest request,
  }) async {
    final response = await _dio.post(
      AuthEndpoints.postAuthLogin,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  // 판매자 회원가입
  Future<RegisterResponse> authRegisterSeller({
    required RegisterSellerRequest request,
  }) async {
    final response = await _dio.post(
      AuthEndpoints.postAuthRegisterSeller,
      data: request.toJson(),
    );
    return RegisterResponse.fromJson(response.data);
  }

  // 구매자 회원가입
  Future<RegisterResponse> authRegisterBuyer({
    required RegisterBuyerRequest request,
  }) async {
    final response = await _dio.post(
      AuthEndpoints.postAuthRegisterSeller,
      data: request.toJson(),
    );
    return RegisterResponse.fromJson(response.data);
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
}