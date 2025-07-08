abstract class SellerFundingEndpoints {
  static String getFunding = '/api/seller/fundings';


  static String getFundingDetail({
    required String id
  }) {
    return '/api/seller/fundings/$id';
  }
}