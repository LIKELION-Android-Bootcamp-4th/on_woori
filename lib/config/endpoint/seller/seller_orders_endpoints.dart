abstract class SellerOrdersEndpoints {
  // 판매자 주문 목록 조회
  static String getSellerOrders = '/api/seller/orders';

  // 판매 주문 상세 조회
  static String getSellerOrdersDetail({
    required String orderId
  }) {
    return  '/api/seller/orders/$orderId';
  }

  // 판매자 주문 상태 변경
  static String getSellerOrdersStatus({
    required String orderId
  }) {
    return  '/api/seller/orders/$orderId/status';
  }

  // 판매자 주문 취소
  static String getSellerOrdersCancel({
    required String orderId
  }) {
    return  '/api/seller/orders/$orderId/cancel';
  }

  // 판매자 주문 환불
  static String getSellerOrdersRefund({
    required String orderId
  }) {
    return  '/api/seller/orders/$orderId/refund';
  }
}