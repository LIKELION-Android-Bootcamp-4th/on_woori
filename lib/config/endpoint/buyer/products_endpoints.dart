abstract class ProductsEndpoints {
  // 상품 목록 검색
  static String getProducts = '/api/products?q=%25';

  // 상품 상세 조회
  static String getProductDetail({
    required String id
  }) {
    return '/api/products/$id';
  }
}