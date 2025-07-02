// 구매자 - 펀딩 API 엔드포인트
abstract class FundingsEndpoints {
  // 공개 펀딩 목록 조회
  static String getFundings = '/api/fundings';

  // 펀딩 상세 조회
  static String getFundingsDetail({
    required String fundingId
  }) {
    return '/api/fundings/$fundingId';
  }
}
