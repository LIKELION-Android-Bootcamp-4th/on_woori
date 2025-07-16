// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '온우리';

  @override
  String get navBarHome => '홈';

  @override
  String get navBarCategory => '카테고리';

  @override
  String get navBarWish => '위시리스트';

  @override
  String get navBarMyPage => '마이페이지';

  @override
  String get homeSlogan => '나를 위한 오늘의 한복';

  @override
  String get homeRecommendedProducts => '추천 상품';

  @override
  String get homeOngoingFunding => '진행중인 펀딩';

  @override
  String get homeBrandList => '브랜드 둘러보기';

  @override
  String homePageError(String error) {
    return '오류 발생: $error';
  }

  @override
  String get homePageNoData => '데이터가 없습니다.';

  @override
  String get homePageNoBrand => '브랜드 없음';

  @override
  String get loginPageTitle => '로그인';

  @override
  String get loginEmailLabel => '이메일';

  @override
  String get loginEmailHint => '이메일 주소를 입력하세요';

  @override
  String get loginPasswordLabel => '비밀번호';

  @override
  String get loginPasswordHint => '비밀번호를 입력하세요';

  @override
  String get loginPasswordReset => '비밀번호 재설정';

  @override
  String get loginButton => '로그인';

  @override
  String get loginPromptSignUp => '온우리가 처음이신가요? ';

  @override
  String get loginSuccess => '로그인 되었습니다.';

  @override
  String get loginErrorBadRequest => '요청이 잘못되었습니다.';

  @override
  String get loginErrorUnauthorized => '이메일 또는 비밀번호가 일치하지 않습니다.';

  @override
  String get loginErrorForbidden => '계정이 비활성화되었거나 인증되지 않았습니다.';

  @override
  String get loginErrorServer => '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';

  @override
  String get loginErrorUnexpected => '예상치 못한 오류가 발생했습니다.';

  @override
  String get signUpPageTitle => '회원가입';

  @override
  String get signUpPageSubtitle => '어떤 사용자인가요?';

  @override
  String get signUpPageSubtitleCommon => '공통';

  @override
  String get signUpUserTypeConsumer => '구매자';

  @override
  String get signUpUserTypeSeller => '판매자';

  @override
  String get signUpSuccess => '회원가입 및 로그인이 완료되었습니다.';

  @override
  String get signUpErrorServer => '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';

  @override
  String get signUpErrorBadRequest => '입력값을 확인해주세요.';

  @override
  String get signUpErrorConflict => '이미 가입된 이메일입니다.';

  @override
  String get signUpErrorUnexpected => '알 수 없는 오류가 발생했습니다. 개발자에게 문의해주세요.';

  @override
  String get signUpNicknameLabel => '닉네임';

  @override
  String get signUpNicknameHint => '닉네임을 입력해주세요';

  @override
  String get signUpPasswordLabel => '비밀번호';

  @override
  String get signUpPasswordHint => '비밀번호를 입력해주세요';

  @override
  String get signUpPasswordConfirmLabel => '비밀번호 확인';

  @override
  String get signUpPasswordConfirmHint => '비밀번호를 한번 더 입력해주세요';

  @override
  String get validatorRequired => '내용을 입력해주세요';

  @override
  String get validatorPasswordMismatch => '입력한 비밀번호가 서로 다릅니다';

  @override
  String get validatorPasswordInvalid => '8자 이상, 숫자/대문자/소문자/특수문자를 포함해야 합니다';

  @override
  String get validatorEmailInvalid => '잘못된 이메일 형식입니다';

  @override
  String get passwordEditPageTitle => '비밀번호 수정';

  @override
  String get passwordEditCurrentPasswordLabel => '현재 비밀번호';

  @override
  String get passwordEditNewPasswordLabel => '새 비밀번호';

  @override
  String get passwordEditConfirmPasswordLabel => '비밀번호 확인';

  @override
  String get passwordEditHint => '비밀번호 입력';

  @override
  String get passwordEditButton => '비밀번호 변경';

  @override
  String get passwordEditErrorLength => '새 비밀번호는 최소 6자리 이상이어야 합니다.';

  @override
  String get passwordEditErrorSameAsCurrent => '새 비밀번호는 현재 비밀번호와 달라야 합니다.';

  @override
  String get passwordEditErrorMismatch => '새 비밀번호가 일치하지 않습니다.';

  @override
  String get passwordEditErrorInvalidUser => '사용자 정보가 올바르지 않습니다.';

  @override
  String get passwordEditSuccess => '비밀번호가 성공적으로 변경되었습니다.';

  @override
  String get passwordEditErrorFailed => '비밀번호 변경에 실패했습니다. 다시 시도해주세요.';

  @override
  String get passwordEditErrorUnexpected => '알 수 없는 오류가 발생했습니다.';

  @override
  String get editProfilePageTitle => '프로필 수정';

  @override
  String get editProfileCamera => '카메라로 촬영';

  @override
  String get editProfileGallery => '갤러리에서 선택';

  @override
  String get editProfileNicknameLabel => '닉네임';

  @override
  String get editProfileNicknameHint => '닉네임을 입력해주세요';

  @override
  String get editProfileSaveButton => '저장';

  @override
  String get editProfileImagePicking => '이미 이미지 선택 중입니다.';

  @override
  String get editProfileSellerPageTitle => '프로필 수정';

  @override
  String get editProfileSellerManagerLabel => '담당자명';

  @override
  String get editProfileSellerManagerHint => '담당자명을 입력해주세요';

  @override
  String get editProfileSellerPhoneLabel => '전화번호';

  @override
  String get editProfileSellerPhoneHint => '전화번호를 입력해주세요';

  @override
  String get editProfileSellerZipcodeLabel => '우편번호';

  @override
  String get editProfileSellerZipcodeHint => '우편번호를 입력해주세요';

  @override
  String get editProfileSellerZipcodeInvalid => '우편번호는 5자리 숫자로 입력해주세요';

  @override
  String get editProfileSellerAddressLabel => '주소';

  @override
  String get editProfileSellerAddressHint => '주소를 입력해주세요';

  @override
  String get editProfileSellerDetailAddressLabel => '상세주소';

  @override
  String get editProfileSellerDetailAddressHint => '상세주소를 입력해주세요';

  @override
  String get editProfileSellerSaveButton => '저장';

  @override
  String get brandEditPageTitle => '브랜드 수정';

  @override
  String get brandEditImagePicking => '이미 이미지 선택 중입니다.';

  @override
  String get brandEditCamera => '카메라로 촬영';

  @override
  String get brandEditGallery => '갤러리에서 선택';

  @override
  String brandEditUpdateFailed(String error) {
    return '수정 실패: $error';
  }

  @override
  String brandEditFetchError(String error) {
    return '오류 발생: $error';
  }

  @override
  String get brandEditNoData => '데이터가 없습니다.';

  @override
  String get brandEditNameLabel => '브랜드 이름';

  @override
  String get brandEditNameHint => '(이름)';

  @override
  String get brandEditDescriptionLabel => '브랜드 소개';

  @override
  String get brandEditDescriptionHint => '(소개글) (최대 nn자)';

  @override
  String get brandEditSaveButton => '저장';

  @override
  String get myPageDefaultUserName => '사용자';

  @override
  String get myPageUserSuffix => '고객님';

  @override
  String get myPageSellerSuffix => '판매자님';

  @override
  String get myPageProfileEditButton => '프로필 수정';

  @override
  String get myPageBrandEditButton => '브랜드 수정';

  @override
  String get myPageSectionShopping => '쇼핑';

  @override
  String get myPageSectionOrder => '주문';

  @override
  String get myPageOrderHistory => '주문 내역';

  @override
  String get myPageWishlist => '위시리스트';

  @override
  String get myPageSectionMyInfo => '내 정보';

  @override
  String get myPageChangePassword => '비밀번호 변경';

  @override
  String get myPageRegisterProduct => '상품 등록';

  @override
  String get myPageRegisterFunding => '펀딩 등록';

  @override
  String get myPageManageItems => '등록 상품 / 펀딩 관리';

  @override
  String get myPageLogout => '로그아웃';

  @override
  String get myPageLogoutSuccess => '로그아웃 되었습니다.';

  @override
  String myPageLogoutFailed(String message) {
    return '로그아웃 실패 : $message';
  }

  @override
  String myPageLogoutError(String error) {
    return '로그아웃 중 오류: $error';
  }

  @override
  String get myPageNoData => '데이터가 없습니다.';

  @override
  String get productRegisterPageTitle => '신규 상품 등록';

  @override
  String get productRegisterThumbnailImageLabel => '대표 이미지';

  @override
  String get productRegisterNameLabel => '상품 이름';

  @override
  String get productRegisterNameHint => '(이름)';

  @override
  String get productRegisterPriceLabel => '상품 가격 (정가 기준)';

  @override
  String get productRegisterPriceHint => '200,000';

  @override
  String get productRegisterDiscountLabel => '상품 할인율 (미기재시 0%)';

  @override
  String get productRegisterDiscountHint => 'Ex : 10';

  @override
  String get productRegisterDisplayPriceLabel => '표시 가격 (할인율 반영)';

  @override
  String get productRegisterDisplayPriceHint => 'Ex : 180,000';

  @override
  String get productRegisterDescriptionLabel => '상품 소개글';

  @override
  String get productRegisterDescriptionHint => '(소개글)';

  @override
  String get productRegisterSizeOptionLabel => '사이즈 옵션';

  @override
  String get productRegisterCategoryLabel => '카테고리 분류';

  @override
  String get productRegisterDetailImageLabel => '상품 소개 이미지 (선택)';

  @override
  String get productRegisterButton => '상품 등록';

  @override
  String get productRegisterAddDetailImage => '상세 이미지 추가';

  @override
  String get productRegisterErrorMaxImages => '이미지는 최대 5개까지 등록할 수 있습니다.';

  @override
  String get productRegisterErrorNoThumbnail => '대표 이미지를 등록해주세요.';

  @override
  String get productRegisterErrorNoNamePrice => '상품 이름과 가격은 필수입니다.';

  @override
  String get productRegisterErrorNoSize => '사이즈 옵션을 하나 이상 선택해주세요.';

  @override
  String productRegisterErrorImageUploadFailed(String message) {
    return '상세 이미지 업로드에 실패했습니다: $message';
  }

  @override
  String get productRegisterErrorLength => '상품명은 2글자 이상이여야 합니다.';

  @override
  String get productRegisterSuccess => '상품이 성공적으로 등록되었습니다.';

  @override
  String productRegisterErrorFailed(String message) {
    return '상품 등록에 실패했습니다: $message';
  }

  @override
  String productRegisterErrorUnexpected(String error) {
    return '상품 등록 중 오류가 발생했습니다: $error';
  }

  @override
  String get productEditPageTitle => '상품 수정';

  @override
  String get productEditButton => '상품 수정';

  @override
  String productEditFetchError(String error) {
    return '상품 정보를 불러오는 데 실패했습니다: $error';
  }

  @override
  String get productEditSuccess => '상품이 성공적으로 수정되었습니다.';

  @override
  String productEditErrorUpdateFailed(String error) {
    return '상품 수정 중 오류가 발생했습니다: $error';
  }

  @override
  String get fundingRegisterPageTitle => '신규 펀딩 등록';

  @override
  String get fundingRegisterCamera => '카메라로 촬영';

  @override
  String get fundingRegisterGallery => '갤러리에서 선택';

  @override
  String get fundingRegisterThumbnailLabel => '대표 이미지';

  @override
  String get fundingRegisterNameLabel => '펀딩명';

  @override
  String get fundingRegisterNameHint => '(이름)';

  @override
  String get fundingRegisterLinkLabel => '펀딩 링크';

  @override
  String get fundingRegisterLinkHint => 'https://www.';

  @override
  String get fundingRegisterButton => '펀딩 추가';

  @override
  String productListPageError(String error) {
    return '오류 발생: $error';
  }

  @override
  String get productListPageNoData => '데이터가 없습니다.';

  @override
  String get productListPageEmpty => '표시할 상품이 없습니다.';

  @override
  String productListPageProcessingError(String error) {
    return '데이터 처리 중 오류가 발생했습니다: $error';
  }

  @override
  String get productDetailPageTitle => '상품 상세 정보';

  @override
  String get productDetailTotalPrice => '총 합산액';

  @override
  String get productDetailAddToCartButton => '장바구니';

  @override
  String get productDetailOrderButton => '주문하기';

  @override
  String get productDetailLoginRequiredTitle => '로그인 필요';

  @override
  String get productDetailLoginRequiredContent =>
      '로그인이 필요한 기능입니다. 로그인 페이지로 이동하시겠습니까?';

  @override
  String get productDetailToggleFavoriteError => '오류가 발생했습니다. 다시 시도해주세요.';

  @override
  String get productDetailSelectSizePrompt => '사이즈를 선택해주세요.';

  @override
  String get productDetailSelectColorPrompt => '색상을 선택해주세요.';

  @override
  String get productDetailAddToCartSuccess => '장바구니에 상품을 추가했습니다.';

  @override
  String productDetailAddToCartFailed(String error) {
    return '장바구니 추가에 실패했습니다: $error';
  }

  @override
  String productDetailAddToCartError(String error) {
    return '오류가 발생했습니다: $error';
  }

  @override
  String productDetailFetchError(String error) {
    return '오류 발생: $error';
  }

  @override
  String get productDetailNoData => '상품 정보를 찾을 수 없습니다.';

  @override
  String get productDetailNoBrand => '브랜드 정보 없음';

  @override
  String get productDetailDefaultCategory => '카테고리';

  @override
  String get productDetailSizeDropdownHint => '사이즈 선택';

  @override
  String get productDetailColorDropdownHint => '색상 선택';

  @override
  String productDetailSelectedOptionSize(String size) {
    return '사이즈: $size';
  }

  @override
  String productDetailSelectedOptionColor(String color) {
    return '색상: $color';
  }

  @override
  String productDetailDiscountPercent(String rate) {
    return '$rate%';
  }

  @override
  String get orderDetailPageTitle => '주문상세조회';

  @override
  String orderDetailPageError(String error) {
    return '오류가 발생했습니다: $error';
  }

  @override
  String get orderDetailPageNoData => '주문 정보를 찾을 수 없습니다.';

  @override
  String get orderDetailSectionProducts => '주문 상품';

  @override
  String get orderDetailSectionPayment => '결제 정보';

  @override
  String orderDetailHeaderNumber(String orderNumber) {
    return '주문번호 $orderNumber';
  }

  @override
  String orderDetailProductOptions(String options, int quantity) {
    return '$options | $quantity개';
  }

  @override
  String get orderDetailTotalProductAmount => '총 상품 금액';

  @override
  String get orderDetailShippingFee => '총 배송비';

  @override
  String get orderDetailTotalPayment => '결제 금액';

  @override
  String get productManagementPageTitle => '상품 관리';

  @override
  String get productManagementProductTab => '상품';

  @override
  String get productManagementFundingTab => '펀딩';

  @override
  String brandDetailPageError(String error) {
    return '오류 발생: $error';
  }

  @override
  String get brandDetailPageNoData => '데이터가 없습니다.';

  @override
  String get brandDetailDefaultName => '브랜드 이름';

  @override
  String get brandDetailDefaultDescription => '브랜드 소개';

  @override
  String get brandDetailProductsError => '상품 정보를 가져오지 못했습니다.';

  @override
  String get brandDetailProductsNoData => '상품 데이터가 없습니다.';

  @override
  String get brandDetailNoRecommendedProducts => '추천 상품이 없습니다.';

  @override
  String get brandDetailNoOngoingFunding => '진행중인 펀딩이 없습니다.';

  @override
  String get cartPageTitle => '장바구니';

  @override
  String get cartItemDeletedSuccess => '상품이 장바구니에서 삭제되었습니다.';

  @override
  String cartItemDeleteFailed(String error) {
    return '삭제에 실패했습니다: $error';
  }

  @override
  String get cartEmptyError => '장바구니에 상품이 없습니다.';

  @override
  String get cartCheckoutSuccess => '주문이 생성되었습니다.';

  @override
  String cartCheckoutFailed(String message) {
    return '주문 생성에 실패했습니다: $message';
  }

  @override
  String cartCheckoutError(String error) {
    return '주문 중 오류가 발생했습니다: $error';
  }

  @override
  String cartGenericError(String error) {
    return '오류가 발생했습니다.\n$error';
  }

  @override
  String get cartEmptyMessage => '장바구니가 비었습니다.';

  @override
  String cartCheckoutButton(String price) {
    return '$price원 결제하기';
  }

  @override
  String get wishlistEmpty => '위시리스트에 추가된 상품이 없습니다.';

  @override
  String get wishlistNoItemsToDisplay => '표시할 상품이 없습니다.';

  @override
  String get commonEdit => '수정';

  @override
  String get commonMore => '더보기';

  @override
  String get commonCancel => '취소';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonMultiSelect => '다중선택';

  @override
  String get commonSelectAll => '모두 선택';

  @override
  String get commonDeselectAll => '전체 해제';

  @override
  String get commonDeleteSelected => '선택 삭제';

  @override
  String get commonAdminAuthFailed => '관리자 인증에 실패했습니다.';

  @override
  String get commonSelectItemToDelete => '삭제할 항목을 선택해주세요.';

  @override
  String commonDeleteFailed(String error) {
    return '삭제에 실패했습니다: $error';
  }

  @override
  String get productDeleteTitle => '상품 삭제';

  @override
  String get productDeleteConfirm => '정말로 이 상품을 삭제하시겠습니까?';

  @override
  String get productDeleteSuccess => '상품이 삭제되었습니다.';

  @override
  String get productBulkDeleteTitle => '상품 일괄 삭제';

  @override
  String productBulkDeleteConfirm(int count) {
    return '$count개의 상품을 정말로 삭제하시겠습니까?';
  }

  @override
  String get productBulkDeleteFailed => '일부 상품 삭제에 실패했습니다.';

  @override
  String productBulkDeleteSuccess(int count) {
    return '$count개의 상품이 삭제되었습니다.';
  }

  @override
  String productSelectedCount(int count) {
    return '선택된 상품 $count개';
  }

  @override
  String productOnSaleCount(int count) {
    return '판매중 상품 $count개';
  }

  @override
  String fundingSelectedCount(int count) {
    return '선택된 펀딩 $count개';
  }

  @override
  String fundingRegisteredCount(int count) {
    return '등록된 펀딩 $count개';
  }

  @override
  String get categoryOuter => '아우터';

  @override
  String get categoryOuter_coat => '코트';

  @override
  String get categoryOuter_jacket => '재킷';

  @override
  String get categoryOuter_vest => '조끼';

  @override
  String get categoryOuter_etc => '가디건 외';

  @override
  String get categoryTop => '상의';

  @override
  String get categoryTop_sleeveless => '민소매';

  @override
  String get categoryTop_shortSleeve => '반소매';

  @override
  String get categoryTop_longSleeve => '긴소매';

  @override
  String get categoryTop_shirt => '셔츠';

  @override
  String get categoryTop_etc => '티셔츠 외';

  @override
  String get categoryBottom => '하의';

  @override
  String get categoryBottom_skirt => '치마';

  @override
  String get categoryBottom_underSkirt => '속치마';

  @override
  String get categoryBottom_longSkirt => '허리치마';

  @override
  String get categoryBottom_miniSkirt => '미니스커트';

  @override
  String get categoryBottom_etcSkirt => '기타 치마';

  @override
  String get categoryBottom_pants => '바지';

  @override
  String get categoryBottom_underPants => '속바지';

  @override
  String get categoryBottom_shortPants => '반바지';

  @override
  String get categoryBottom_longPants => '긴바지';

  @override
  String get categoryBottom_etcPants => '기타 바지';

  @override
  String get categoryGoods => '잡화';

  @override
  String get categoryGoods_head => '머리장식';

  @override
  String get categoryGoods_norigae => '노리개';

  @override
  String get categoryGoods_bag => '가방';

  @override
  String get categoryGoods_neck => '목걸이';

  @override
  String get categoryGoods_ear => '귀걸이';

  @override
  String get categoryGoods_ring => '반지';

  @override
  String get categoryGoods_etc => '기타 잡화';

  @override
  String currencyFormat(String price) {
    return '$price원';
  }

  @override
  String get dummyImage =>
      'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg';
}
