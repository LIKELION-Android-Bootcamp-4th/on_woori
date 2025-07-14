abstract class SellerFundingEndpoints {
  // 판매자 펀딩 목록 조회
  static String getFunding = '/api/seller/fundings';

  // 펀딩 상세 조회
  static String getFundingDetail({required String id}) {
    return '/api/seller/fundings/$id';
  }

  // 펀딩 수정
  static String editFunding({required String id}) {
    return '/api/seller/fundings/$id';
  }
}
