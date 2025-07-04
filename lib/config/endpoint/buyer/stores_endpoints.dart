abstract class StoresEndpoints {
  // 상점 목록 조회
  static String getStores = '/api/stores';

  static String getStoreDetail({
    required String id
  }) {
    return '/api/stores/$id';
  }

  static String getStoreProducts({
    required String id
  }) {
    return '/api/stores/$id/products';
  }
}