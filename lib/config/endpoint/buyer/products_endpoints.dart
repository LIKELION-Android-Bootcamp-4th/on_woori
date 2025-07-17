abstract class ProductsEndpoints {
  // 상품 목록 검색
  static String getProducts = '/api/products';

  // 상품 상세 조회
  static String getProductDetail({required String id}) {
    return '/api/products/$id';
  }

  // 상품 등록 (동적 필드 지원)
  static String getProductRegister = '/api/seller/products';

  // 상품 수정 (동적 필드 지원)
  static String patchProductUpdate({required String id}) {
    return '/api/seller/products/$id';
  }

  static String postProductToggleFavorites({required String productId}) {
    return '/api/products/$productId/toggle-favorites';
  }
}
