// 구매자 - 장바구니 API 엔드포인트
abstract class CartEndpoints {
  // 내 장바구니 조회
  static String getCart = '/api/cart';

  // 장바구니에 상품 추가
  static String postCart = '/api/cart';

  // 장바구니에서 선택된 상품 제거
  static String deleteCart = '/api/cart';

  // 내 장바구니 개수
  static String getCartCount = '/api/cart/count';

  // 장바구니 비우기
  static String deleteCartClean = '/api/cart/clear';

  // 장바구니 상품으로 주문 생성 (전체 또는 선택 상품)
  static String postCartCheckOut = '/api/cart/checkout';
}
