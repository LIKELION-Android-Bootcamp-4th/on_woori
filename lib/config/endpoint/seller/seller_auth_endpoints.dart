// 인증 API 엔드포인트
abstract class SellerAuthEndpoints {
  // 로그인(전체)
  static String postAuthLogin = '/api/auth/login';

  // 소셜 로그인
  static String postAuthSnsLogin = "/api/auth/sns-login";

  // AccessToken 갱신
  static String postAuthRefresh = "/api/auth/refresh";

  // 로그아웃(전체)
  static String postAuthLogout = "/api/auth/logout";

  // 판매자 회원가입(이메일 인증 필요)
  static String postAuthRegisterSeller = "/api/auth/register/seller";

  // 구매자 회원가입(이메일 인증 필요)
  static String postAuthRegisterBuyer = "/api/auth/register/buyer";

  // 이메일 인증 코드 확인
  static String postAuthVerifyEmail = "/api/auth/verify-email";

  // 이메일 인증 코드 재발송
  static String postAuthResendVerification = "/api/auth/verification";

}