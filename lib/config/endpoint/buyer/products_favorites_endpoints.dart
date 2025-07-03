abstract class ProductsFavoritesEndpoints {
  // 특정 상품 찜 여부 확인
  static String getProductsFavorites({
    required String productId
  }) {
    return '/api/products/$productId/favorites';
  }

  // 상품 찜 토클(추가 또는 삭제)
  static String postProductToggleFavorites({
    required String productId
  }) {
    return '/api/products/$productId/toggle-favorites';
  }

  static String getMyFavorites() {
    return '/api/mypage/favorites';
  }
}

