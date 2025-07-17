// 구매자 - 카테고리 API 엔드포인트
abstract class CategoriesEndpoints {
  // 카테고리 트리 조회 (공개)
  static String getCategoriesTree = '/api/categories/tree';

  // 카테고리 Breadcrumb 조회
  static String getCategoriesBreadcrumb({required int categoryId}) {
    return '/api/categories/breadcrumb/$categoryId';
  }

  // slug로 카테고리 조회
  static String getCategoriesSlug({required String slug}) {
    return '/api/categories/slug/$slug';
  }

  // 카테고리 목록 조회 (공개)
  static String getCategories = '/api/categories/';

  // ID로 카테고리 상세 조회
  static String getCategoriesDetail({required String categoryId}) {
    return '/api/categories/$categoryId';
  }
}
