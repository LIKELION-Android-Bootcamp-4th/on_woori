abstract class OrderEndpoints {
  // 주문 생성
  static String postOrders = '/api/orders';

  // 내 주문 목록 조회
  static String getOrders = '/api/orders';

  // 주문 상세 조회
  static String getOrdersDetail({
    required String orderId
  }) {
    return '/api/orders/$orderId';
  }

  // 주문 상태 변경
  static String patchOrdersStatus({
    required String orderId
  }) {
    return '/api/orders/$orderId/status';
  }

  // 주문 완료 변경
  static String putOrdersComplete({
    required String orderId
  }) {
    return '/api/orders/$orderId/complete';
  }

  // 주문 취소
  static String patchOrdersCancel({
    required int orderId
  }) {
    return '/api/orders/$orderId/cancel';
  }

  // 주문 환불
  static String patchOrdersRefund({
    required int orderId
  }) {
    return '/api/orders/$orderId/refund';
  }

}