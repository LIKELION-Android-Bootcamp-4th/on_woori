abstract class SellerProductsEndpoints {
  // 판매자 상품 목록 조회 (동적 필드 포함)
  static String getSellerProducts = '/api/seller/products';

  // 상품 등록 (동적 필드 지원)
  static String postSellerProducts = '/api/seller/products';

  // 상품 상세 조회 (동적 필드 포함)
  static String getSellerProductsDetail({
    required String productId
  }) {
    return '/api/seller/products/$productId';
  }

  // 상품 수정 (동적 필드 지원)
  static String patchSellerProducts({
    required String productId
  }) {
    return '/api/seller/products/$productId';
  }
}