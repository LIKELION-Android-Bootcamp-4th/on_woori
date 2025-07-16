// 관리자 - 상품 관리 API 엔드포인트
abstract class AdminProductEndpoints {
  // 상품 삭제
  static String deleteAdminProductsForce({required String id}) {
    return '/api/admin/products/$id';
  }

  // 비밀번호 변경(관리자용)
  static String changeAuthUserPassword() {
    return '/api/mypage/change-password';
  }
}
