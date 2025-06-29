// 관리자 - 상품 관리 API 엔드포인트
abstract class AdminProductEndpoints {

  // 목록 조회
  static String getAdminProducts = '/admin/products';

  // 상품 등록
  static String postAdminProducts = '/admin/products';

  // 상품 수정
  static String putAdminProducts({
    required int id
  }) {
    return '/admin/products/$id';
  }

  // 상품 삭제
  static String deleteAdminProducts({
    required int id
  }) {
    return '/admin/products/$id';
  }
}