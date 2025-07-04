abstract class ProductsEndpoints {
  // 상품 목록 검색
  // TODO : 제품 조회쪽 이슈 있으니까 q = 25 추가로 보냅니다.
  static String getProducts = '/api/products?q=%25';

  // 상품 상세 조회
  static String getProductDetail({
    required String id
  }) {
    return '/api/products/$id';
  }
}