// 관리자 - 상품 관리 API 엔드포인트
abstract class AdminProductEndpoints {

  // 상품 삭제
  static String deleteAdminProductsForce({
    required String id
  }) {
    return '/api/admin/products/$id/force';
  }
}