abstract class MyPageEndpoints {
  // 찜한 상품 목록 조회
  static String getMyPageFavorites = '/api/mypage/favorites';

  // 내 프로필 조회
  static String getMyPageProfile = '/api/mypage/profile';

  // 내 프로필 수정
  static String putMyPageProfile = '/api/mypage/profile';

  // 비밀번호 변경
  static String patchMyPageChangePassword = '/api/mypage/change-password';
}