import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ko')];

  /// No description provided for @appTitle.
  ///
  /// In ko, this message translates to:
  /// **'온우리'**
  String get appTitle;

  /// No description provided for @navBarHome.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get navBarHome;

  /// No description provided for @navBarCategory.
  ///
  /// In ko, this message translates to:
  /// **'카테고리'**
  String get navBarCategory;

  /// No description provided for @navBarWish.
  ///
  /// In ko, this message translates to:
  /// **'위시리스트'**
  String get navBarWish;

  /// No description provided for @navBarMyPage.
  ///
  /// In ko, this message translates to:
  /// **'마이페이지'**
  String get navBarMyPage;

  /// No description provided for @homeSlogan.
  ///
  /// In ko, this message translates to:
  /// **'나를 위한 오늘의 한복'**
  String get homeSlogan;

  /// No description provided for @homeRecommendedProducts.
  ///
  /// In ko, this message translates to:
  /// **'추천 상품'**
  String get homeRecommendedProducts;

  /// No description provided for @homeOngoingFunding.
  ///
  /// In ko, this message translates to:
  /// **'진행중인 펀딩'**
  String get homeOngoingFunding;

  /// No description provided for @homeBrandList.
  ///
  /// In ko, this message translates to:
  /// **'브랜드 둘러보기'**
  String get homeBrandList;

  /// No description provided for @homePageError.
  ///
  /// In ko, this message translates to:
  /// **'오류 발생: {error}'**
  String homePageError(String error);

  /// No description provided for @homePageNoData.
  ///
  /// In ko, this message translates to:
  /// **'데이터가 없습니다.'**
  String get homePageNoData;

  /// No description provided for @homePageNoBrand.
  ///
  /// In ko, this message translates to:
  /// **'브랜드 없음'**
  String get homePageNoBrand;

  /// No description provided for @loginPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get loginPageTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In ko, this message translates to:
  /// **'이메일'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailHint.
  ///
  /// In ko, this message translates to:
  /// **'이메일 주소를 입력하세요'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호를 입력하세요'**
  String get loginPasswordHint;

  /// No description provided for @loginPasswordReset.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 재설정'**
  String get loginPasswordReset;

  /// No description provided for @loginButton.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get loginButton;

  /// No description provided for @loginPromptSignUp.
  ///
  /// In ko, this message translates to:
  /// **'온우리가 처음이신가요? '**
  String get loginPromptSignUp;

  /// No description provided for @loginSuccess.
  ///
  /// In ko, this message translates to:
  /// **'로그인 되었습니다.'**
  String get loginSuccess;

  /// No description provided for @loginErrorBadRequest.
  ///
  /// In ko, this message translates to:
  /// **'요청이 잘못되었습니다.'**
  String get loginErrorBadRequest;

  /// No description provided for @loginErrorUnauthorized.
  ///
  /// In ko, this message translates to:
  /// **'이메일 또는 비밀번호가 일치하지 않습니다.'**
  String get loginErrorUnauthorized;

  /// No description provided for @loginErrorForbidden.
  ///
  /// In ko, this message translates to:
  /// **'계정이 비활성화되었거나 인증되지 않았습니다.'**
  String get loginErrorForbidden;

  /// No description provided for @loginErrorServer.
  ///
  /// In ko, this message translates to:
  /// **'서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'**
  String get loginErrorServer;

  /// No description provided for @loginErrorUnexpected.
  ///
  /// In ko, this message translates to:
  /// **'예상치 못한 오류가 발생했습니다.'**
  String get loginErrorUnexpected;

  /// No description provided for @signUpPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'회원가입'**
  String get signUpPageTitle;

  /// No description provided for @signUpPageSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'어떤 사용자인가요?'**
  String get signUpPageSubtitle;

  /// No description provided for @signUpPageSubtitleCommon.
  ///
  /// In ko, this message translates to:
  /// **'공통'**
  String get signUpPageSubtitleCommon;

  /// No description provided for @signUpUserTypeConsumer.
  ///
  /// In ko, this message translates to:
  /// **'구매자'**
  String get signUpUserTypeConsumer;

  /// No description provided for @signUpUserTypeSeller.
  ///
  /// In ko, this message translates to:
  /// **'판매자'**
  String get signUpUserTypeSeller;

  /// No description provided for @signUpSuccess.
  ///
  /// In ko, this message translates to:
  /// **'회원가입 및 로그인이 완료되었습니다.'**
  String get signUpSuccess;

  /// No description provided for @signUpErrorServer.
  ///
  /// In ko, this message translates to:
  /// **'서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'**
  String get signUpErrorServer;

  /// No description provided for @signUpErrorBadRequest.
  ///
  /// In ko, this message translates to:
  /// **'입력값을 확인해주세요.'**
  String get signUpErrorBadRequest;

  /// No description provided for @signUpErrorConflict.
  ///
  /// In ko, this message translates to:
  /// **'이미 가입된 이메일입니다.'**
  String get signUpErrorConflict;

  /// No description provided for @signUpErrorUnexpected.
  ///
  /// In ko, this message translates to:
  /// **'알 수 없는 오류가 발생했습니다. 개발자에게 문의해주세요.'**
  String get signUpErrorUnexpected;

  /// No description provided for @signUpNicknameLabel.
  ///
  /// In ko, this message translates to:
  /// **'닉네임'**
  String get signUpNicknameLabel;

  /// No description provided for @signUpNicknameHint.
  ///
  /// In ko, this message translates to:
  /// **'닉네임을 입력해주세요'**
  String get signUpNicknameHint;

  /// No description provided for @signUpPasswordLabel.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호'**
  String get signUpPasswordLabel;

  /// No description provided for @signUpPasswordHint.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호를 입력해주세요'**
  String get signUpPasswordHint;

  /// No description provided for @signUpPasswordConfirmLabel.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 확인'**
  String get signUpPasswordConfirmLabel;

  /// No description provided for @signUpPasswordConfirmHint.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호를 한번 더 입력해주세요'**
  String get signUpPasswordConfirmHint;

  /// No description provided for @validatorRequired.
  ///
  /// In ko, this message translates to:
  /// **'내용을 입력해주세요'**
  String get validatorRequired;

  /// No description provided for @validatorPasswordMismatch.
  ///
  /// In ko, this message translates to:
  /// **'입력한 비밀번호가 서로 다릅니다'**
  String get validatorPasswordMismatch;

  /// No description provided for @validatorPasswordInvalid.
  ///
  /// In ko, this message translates to:
  /// **'8자 이상, 숫자/대문자/소문자/특수문자를 포함해야 합니다'**
  String get validatorPasswordInvalid;

  /// No description provided for @validatorEmailInvalid.
  ///
  /// In ko, this message translates to:
  /// **'잘못된 이메일 형식입니다'**
  String get validatorEmailInvalid;

  /// No description provided for @passwordEditPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 수정'**
  String get passwordEditPageTitle;

  /// No description provided for @passwordEditCurrentPasswordLabel.
  ///
  /// In ko, this message translates to:
  /// **'현재 비밀번호'**
  String get passwordEditCurrentPasswordLabel;

  /// No description provided for @passwordEditNewPasswordLabel.
  ///
  /// In ko, this message translates to:
  /// **'새 비밀번호'**
  String get passwordEditNewPasswordLabel;

  /// No description provided for @passwordEditConfirmPasswordLabel.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 확인'**
  String get passwordEditConfirmPasswordLabel;

  /// No description provided for @passwordEditHint.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 입력'**
  String get passwordEditHint;

  /// No description provided for @passwordEditButton.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 변경'**
  String get passwordEditButton;

  /// No description provided for @passwordEditErrorLength.
  ///
  /// In ko, this message translates to:
  /// **'새 비밀번호는 최소 6자리 이상이어야 합니다.'**
  String get passwordEditErrorLength;

  /// No description provided for @passwordEditErrorSameAsCurrent.
  ///
  /// In ko, this message translates to:
  /// **'새 비밀번호는 현재 비밀번호와 달라야 합니다.'**
  String get passwordEditErrorSameAsCurrent;

  /// No description provided for @passwordEditErrorMismatch.
  ///
  /// In ko, this message translates to:
  /// **'새 비밀번호가 일치하지 않습니다.'**
  String get passwordEditErrorMismatch;

  /// No description provided for @passwordEditErrorInvalidUser.
  ///
  /// In ko, this message translates to:
  /// **'사용자 정보가 올바르지 않습니다.'**
  String get passwordEditErrorInvalidUser;

  /// No description provided for @passwordEditSuccess.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호가 성공적으로 변경되었습니다.'**
  String get passwordEditSuccess;

  /// No description provided for @passwordEditErrorFailed.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 변경에 실패했습니다. 다시 시도해주세요.'**
  String get passwordEditErrorFailed;

  /// No description provided for @passwordEditErrorUnexpected.
  ///
  /// In ko, this message translates to:
  /// **'알 수 없는 오류가 발생했습니다.'**
  String get passwordEditErrorUnexpected;

  /// No description provided for @myPageDefaultUserName.
  ///
  /// In ko, this message translates to:
  /// **'사용자'**
  String get myPageDefaultUserName;

  /// No description provided for @myPageUserSuffix.
  ///
  /// In ko, this message translates to:
  /// **'고객님'**
  String get myPageUserSuffix;

  /// No description provided for @myPageSellerSuffix.
  ///
  /// In ko, this message translates to:
  /// **'판매자님'**
  String get myPageSellerSuffix;

  /// No description provided for @myPageProfileEditButton.
  ///
  /// In ko, this message translates to:
  /// **'프로필 수정'**
  String get myPageProfileEditButton;

  /// No description provided for @myPageBrandEditButton.
  ///
  /// In ko, this message translates to:
  /// **'브랜드 수정'**
  String get myPageBrandEditButton;

  /// No description provided for @myPageSectionShopping.
  ///
  /// In ko, this message translates to:
  /// **'쇼핑'**
  String get myPageSectionShopping;

  /// No description provided for @myPageSectionOrder.
  ///
  /// In ko, this message translates to:
  /// **'주문'**
  String get myPageSectionOrder;

  /// No description provided for @myPageOrderHistory.
  ///
  /// In ko, this message translates to:
  /// **'주문 내역'**
  String get myPageOrderHistory;

  /// No description provided for @myPageWishlist.
  ///
  /// In ko, this message translates to:
  /// **'위시리스트'**
  String get myPageWishlist;

  /// No description provided for @myPageSectionMyInfo.
  ///
  /// In ko, this message translates to:
  /// **'내 정보'**
  String get myPageSectionMyInfo;

  /// No description provided for @myPageChangePassword.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 변경'**
  String get myPageChangePassword;

  /// No description provided for @myPageRegisterProduct.
  ///
  /// In ko, this message translates to:
  /// **'상품 등록'**
  String get myPageRegisterProduct;

  /// No description provided for @myPageRegisterFunding.
  ///
  /// In ko, this message translates to:
  /// **'펀딩 등록'**
  String get myPageRegisterFunding;

  /// No description provided for @myPageManageItems.
  ///
  /// In ko, this message translates to:
  /// **'등록 상품 / 펀딩 관리'**
  String get myPageManageItems;

  /// No description provided for @myPageLogout.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get myPageLogout;

  /// No description provided for @myPageLogoutSuccess.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃 되었습니다.'**
  String get myPageLogoutSuccess;

  /// No description provided for @myPageLogoutFailed.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃 실패 : {message}'**
  String myPageLogoutFailed(String message);

  /// No description provided for @myPageLogoutError.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃 중 오류: {error}'**
  String myPageLogoutError(String error);

  /// No description provided for @myPageNoData.
  ///
  /// In ko, this message translates to:
  /// **'데이터가 없습니다.'**
  String get myPageNoData;

  /// No description provided for @productRegisterPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'신규 상품 등록'**
  String get productRegisterPageTitle;

  /// No description provided for @productRegisterThumbnailImageLabel.
  ///
  /// In ko, this message translates to:
  /// **'대표 이미지'**
  String get productRegisterThumbnailImageLabel;

  /// No description provided for @productRegisterNameLabel.
  ///
  /// In ko, this message translates to:
  /// **'상품 이름'**
  String get productRegisterNameLabel;

  /// No description provided for @productRegisterNameHint.
  ///
  /// In ko, this message translates to:
  /// **'(이름)'**
  String get productRegisterNameHint;

  /// No description provided for @productRegisterPriceLabel.
  ///
  /// In ko, this message translates to:
  /// **'상품 가격 (정가 기준)'**
  String get productRegisterPriceLabel;

  /// No description provided for @productRegisterPriceHint.
  ///
  /// In ko, this message translates to:
  /// **'200,000'**
  String get productRegisterPriceHint;

  /// No description provided for @productRegisterDiscountLabel.
  ///
  /// In ko, this message translates to:
  /// **'상품 할인율 (미기재시 0%)'**
  String get productRegisterDiscountLabel;

  /// No description provided for @productRegisterDiscountHint.
  ///
  /// In ko, this message translates to:
  /// **'Ex : 10'**
  String get productRegisterDiscountHint;

  /// No description provided for @productRegisterDisplayPriceLabel.
  ///
  /// In ko, this message translates to:
  /// **'표시 가격 (할인율 반영)'**
  String get productRegisterDisplayPriceLabel;

  /// No description provided for @productRegisterDisplayPriceHint.
  ///
  /// In ko, this message translates to:
  /// **'Ex : 180,000'**
  String get productRegisterDisplayPriceHint;

  /// No description provided for @productRegisterDescriptionLabel.
  ///
  /// In ko, this message translates to:
  /// **'상품 소개글'**
  String get productRegisterDescriptionLabel;

  /// No description provided for @productRegisterDescriptionHint.
  ///
  /// In ko, this message translates to:
  /// **'(소개글)'**
  String get productRegisterDescriptionHint;

  /// No description provided for @productRegisterSizeOptionLabel.
  ///
  /// In ko, this message translates to:
  /// **'사이즈 옵션'**
  String get productRegisterSizeOptionLabel;

  /// No description provided for @productRegisterCategoryLabel.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 분류'**
  String get productRegisterCategoryLabel;

  /// No description provided for @productRegisterDetailImageLabel.
  ///
  /// In ko, this message translates to:
  /// **'상품 소개 이미지 (선택)'**
  String get productRegisterDetailImageLabel;

  /// No description provided for @productRegisterButton.
  ///
  /// In ko, this message translates to:
  /// **'상품 등록'**
  String get productRegisterButton;

  /// No description provided for @productRegisterAddDetailImage.
  ///
  /// In ko, this message translates to:
  /// **'상세 이미지 추가'**
  String get productRegisterAddDetailImage;

  /// No description provided for @productRegisterErrorMaxImages.
  ///
  /// In ko, this message translates to:
  /// **'이미지는 최대 5개까지 등록할 수 있습니다.'**
  String get productRegisterErrorMaxImages;

  /// No description provided for @productRegisterErrorNoThumbnail.
  ///
  /// In ko, this message translates to:
  /// **'대표 이미지를 등록해주세요.'**
  String get productRegisterErrorNoThumbnail;

  /// No description provided for @productRegisterErrorNoNamePrice.
  ///
  /// In ko, this message translates to:
  /// **'상품 이름과 가격은 필수입니다.'**
  String get productRegisterErrorNoNamePrice;

  /// No description provided for @productRegisterErrorNoSize.
  ///
  /// In ko, this message translates to:
  /// **'사이즈 옵션을 하나 이상 선택해주세요.'**
  String get productRegisterErrorNoSize;

  /// No description provided for @productRegisterErrorImageUploadFailed.
  ///
  /// In ko, this message translates to:
  /// **'상세 이미지 업로드에 실패했습니다: {message}'**
  String productRegisterErrorImageUploadFailed(String message);

  /// No description provided for @productRegisterSuccess.
  ///
  /// In ko, this message translates to:
  /// **'상품이 성공적으로 등록되었습니다.'**
  String get productRegisterSuccess;

  /// No description provided for @productRegisterErrorFailed.
  ///
  /// In ko, this message translates to:
  /// **'상품 등록에 실패했습니다: {message}'**
  String productRegisterErrorFailed(String message);

  /// No description provided for @productRegisterErrorUnexpected.
  ///
  /// In ko, this message translates to:
  /// **'상품 등록 중 오류가 발생했습니다: {error}'**
  String productRegisterErrorUnexpected(String error);

  /// No description provided for @productEditPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'상품 수정'**
  String get productEditPageTitle;

  /// No description provided for @productEditButton.
  ///
  /// In ko, this message translates to:
  /// **'상품 수정'**
  String get productEditButton;

  /// No description provided for @productEditFetchError.
  ///
  /// In ko, this message translates to:
  /// **'상품 정보를 불러오는 데 실패했습니다: {error}'**
  String productEditFetchError(String error);

  /// No description provided for @productEditSuccess.
  ///
  /// In ko, this message translates to:
  /// **'상품이 성공적으로 수정되었습니다.'**
  String get productEditSuccess;

  /// No description provided for @productEditErrorUpdateFailed.
  ///
  /// In ko, this message translates to:
  /// **'상품 수정 중 오류가 발생했습니다: {error}'**
  String productEditErrorUpdateFailed(String error);

  /// No description provided for @fundingRegisterPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'신규 펀딩 등록'**
  String get fundingRegisterPageTitle;

  /// No description provided for @fundingRegisterCamera.
  ///
  /// In ko, this message translates to:
  /// **'카메라로 촬영'**
  String get fundingRegisterCamera;

  /// No description provided for @fundingRegisterGallery.
  ///
  /// In ko, this message translates to:
  /// **'갤러리에서 선택'**
  String get fundingRegisterGallery;

  /// No description provided for @fundingRegisterThumbnailLabel.
  ///
  /// In ko, this message translates to:
  /// **'대표 이미지'**
  String get fundingRegisterThumbnailLabel;

  /// No description provided for @fundingRegisterNameLabel.
  ///
  /// In ko, this message translates to:
  /// **'펀딩명'**
  String get fundingRegisterNameLabel;

  /// No description provided for @fundingRegisterNameHint.
  ///
  /// In ko, this message translates to:
  /// **'(이름)'**
  String get fundingRegisterNameHint;

  /// No description provided for @fundingRegisterLinkLabel.
  ///
  /// In ko, this message translates to:
  /// **'펀딩 링크'**
  String get fundingRegisterLinkLabel;

  /// No description provided for @fundingRegisterLinkHint.
  ///
  /// In ko, this message translates to:
  /// **'https://www.'**
  String get fundingRegisterLinkHint;

  /// No description provided for @fundingRegisterButton.
  ///
  /// In ko, this message translates to:
  /// **'펀딩 추가'**
  String get fundingRegisterButton;

  /// No description provided for @productListPageError.
  ///
  /// In ko, this message translates to:
  /// **'오류 발생: {error}'**
  String productListPageError(String error);

  /// No description provided for @productListPageNoData.
  ///
  /// In ko, this message translates to:
  /// **'데이터가 없습니다.'**
  String get productListPageNoData;

  /// No description provided for @productListPageEmpty.
  ///
  /// In ko, this message translates to:
  /// **'표시할 상품이 없습니다.'**
  String get productListPageEmpty;

  /// No description provided for @productListPageProcessingError.
  ///
  /// In ko, this message translates to:
  /// **'데이터 처리 중 오류가 발생했습니다: {error}'**
  String productListPageProcessingError(String error);

  /// No description provided for @productDetailPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'상품 상세 정보'**
  String get productDetailPageTitle;

  /// No description provided for @productDetailTotalPrice.
  ///
  /// In ko, this message translates to:
  /// **'총 합산액'**
  String get productDetailTotalPrice;

  /// No description provided for @productDetailAddToCartButton.
  ///
  /// In ko, this message translates to:
  /// **'장바구니'**
  String get productDetailAddToCartButton;

  /// No description provided for @productDetailOrderButton.
  ///
  /// In ko, this message translates to:
  /// **'주문하기'**
  String get productDetailOrderButton;

  /// No description provided for @productDetailLoginRequiredTitle.
  ///
  /// In ko, this message translates to:
  /// **'로그인 필요'**
  String get productDetailLoginRequiredTitle;

  /// No description provided for @productDetailLoginRequiredContent.
  ///
  /// In ko, this message translates to:
  /// **'로그인이 필요한 기능입니다. 로그인 페이지로 이동하시겠습니까?'**
  String get productDetailLoginRequiredContent;

  /// No description provided for @productDetailToggleFavoriteError.
  ///
  /// In ko, this message translates to:
  /// **'오류가 발생했습니다. 다시 시도해주세요.'**
  String get productDetailToggleFavoriteError;

  /// No description provided for @productDetailSelectSizePrompt.
  ///
  /// In ko, this message translates to:
  /// **'사이즈를 선택해주세요.'**
  String get productDetailSelectSizePrompt;

  /// No description provided for @productDetailSelectColorPrompt.
  ///
  /// In ko, this message translates to:
  /// **'색상을 선택해주세요.'**
  String get productDetailSelectColorPrompt;

  /// No description provided for @productDetailAddToCartSuccess.
  ///
  /// In ko, this message translates to:
  /// **'장바구니에 상품을 추가했습니다.'**
  String get productDetailAddToCartSuccess;

  /// No description provided for @productDetailAddToCartFailed.
  ///
  /// In ko, this message translates to:
  /// **'장바구니 추가에 실패했습니다: {error}'**
  String productDetailAddToCartFailed(String error);

  /// No description provided for @productDetailAddToCartError.
  ///
  /// In ko, this message translates to:
  /// **'오류가 발생했습니다: {error}'**
  String productDetailAddToCartError(String error);

  /// No description provided for @productDetailFetchError.
  ///
  /// In ko, this message translates to:
  /// **'오류 발생: {error}'**
  String productDetailFetchError(String error);

  /// No description provided for @productDetailNoData.
  ///
  /// In ko, this message translates to:
  /// **'상품 정보를 찾을 수 없습니다.'**
  String get productDetailNoData;

  /// No description provided for @productDetailNoBrand.
  ///
  /// In ko, this message translates to:
  /// **'브랜드 정보 없음'**
  String get productDetailNoBrand;

  /// No description provided for @productDetailDefaultCategory.
  ///
  /// In ko, this message translates to:
  /// **'카테고리'**
  String get productDetailDefaultCategory;

  /// No description provided for @productDetailSizeDropdownHint.
  ///
  /// In ko, this message translates to:
  /// **'사이즈 선택'**
  String get productDetailSizeDropdownHint;

  /// No description provided for @productDetailColorDropdownHint.
  ///
  /// In ko, this message translates to:
  /// **'색상 선택'**
  String get productDetailColorDropdownHint;

  /// No description provided for @productDetailSelectedOptionSize.
  ///
  /// In ko, this message translates to:
  /// **'사이즈: {size}'**
  String productDetailSelectedOptionSize(String size);

  /// No description provided for @productDetailSelectedOptionColor.
  ///
  /// In ko, this message translates to:
  /// **'색상: {color}'**
  String productDetailSelectedOptionColor(String color);

  /// No description provided for @productDetailDiscountPercent.
  ///
  /// In ko, this message translates to:
  /// **'{rate}%'**
  String productDetailDiscountPercent(String rate);

  /// No description provided for @orderDetailPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'주문상세조회'**
  String get orderDetailPageTitle;

  /// No description provided for @orderDetailPageError.
  ///
  /// In ko, this message translates to:
  /// **'오류가 발생했습니다: {error}'**
  String orderDetailPageError(String error);

  /// No description provided for @orderDetailPageNoData.
  ///
  /// In ko, this message translates to:
  /// **'주문 정보를 찾을 수 없습니다.'**
  String get orderDetailPageNoData;

  /// No description provided for @orderDetailSectionProducts.
  ///
  /// In ko, this message translates to:
  /// **'주문 상품'**
  String get orderDetailSectionProducts;

  /// No description provided for @orderDetailSectionPayment.
  ///
  /// In ko, this message translates to:
  /// **'결제 정보'**
  String get orderDetailSectionPayment;

  /// No description provided for @orderDetailHeaderNumber.
  ///
  /// In ko, this message translates to:
  /// **'주문번호 {orderNumber}'**
  String orderDetailHeaderNumber(String orderNumber);

  /// No description provided for @orderDetailProductOptions.
  ///
  /// In ko, this message translates to:
  /// **'{options} | {quantity}개'**
  String orderDetailProductOptions(String options, int quantity);

  /// No description provided for @orderDetailTotalProductAmount.
  ///
  /// In ko, this message translates to:
  /// **'총 상품 금액'**
  String get orderDetailTotalProductAmount;

  /// No description provided for @orderDetailShippingFee.
  ///
  /// In ko, this message translates to:
  /// **'총 배송비'**
  String get orderDetailShippingFee;

  /// No description provided for @orderDetailTotalPayment.
  ///
  /// In ko, this message translates to:
  /// **'결제 금액'**
  String get orderDetailTotalPayment;

  /// No description provided for @productManagementPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'상품 관리'**
  String get productManagementPageTitle;

  /// No description provided for @productManagementProductTab.
  ///
  /// In ko, this message translates to:
  /// **'상품'**
  String get productManagementProductTab;

  /// No description provided for @productManagementFundingTab.
  ///
  /// In ko, this message translates to:
  /// **'펀딩'**
  String get productManagementFundingTab;

  /// No description provided for @brandDetailPageError.
  ///
  /// In ko, this message translates to:
  /// **'오류 발생: {error}'**
  String brandDetailPageError(String error);

  /// No description provided for @brandDetailPageNoData.
  ///
  /// In ko, this message translates to:
  /// **'데이터가 없습니다.'**
  String get brandDetailPageNoData;

  /// No description provided for @brandDetailDefaultName.
  ///
  /// In ko, this message translates to:
  /// **'브랜드 이름'**
  String get brandDetailDefaultName;

  /// No description provided for @brandDetailDefaultDescription.
  ///
  /// In ko, this message translates to:
  /// **'브랜드 소개'**
  String get brandDetailDefaultDescription;

  /// No description provided for @brandDetailProductsError.
  ///
  /// In ko, this message translates to:
  /// **'상품 정보를 가져오지 못했습니다.'**
  String get brandDetailProductsError;

  /// No description provided for @brandDetailProductsNoData.
  ///
  /// In ko, this message translates to:
  /// **'상품 데이터가 없습니다.'**
  String get brandDetailProductsNoData;

  /// No description provided for @brandDetailNoRecommendedProducts.
  ///
  /// In ko, this message translates to:
  /// **'추천 상품이 없습니다.'**
  String get brandDetailNoRecommendedProducts;

  /// No description provided for @brandDetailNoOngoingFunding.
  ///
  /// In ko, this message translates to:
  /// **'진행중인 펀딩이 없습니다.'**
  String get brandDetailNoOngoingFunding;

  /// No description provided for @cartPageTitle.
  ///
  /// In ko, this message translates to:
  /// **'장바구니'**
  String get cartPageTitle;

  /// No description provided for @cartItemDeletedSuccess.
  ///
  /// In ko, this message translates to:
  /// **'상품이 장바구니에서 삭제되었습니다.'**
  String get cartItemDeletedSuccess;

  /// No description provided for @cartItemDeleteFailed.
  ///
  /// In ko, this message translates to:
  /// **'삭제에 실패했습니다: {error}'**
  String cartItemDeleteFailed(String error);

  /// No description provided for @cartEmptyError.
  ///
  /// In ko, this message translates to:
  /// **'장바구니에 상품이 없습니다.'**
  String get cartEmptyError;

  /// No description provided for @cartCheckoutSuccess.
  ///
  /// In ko, this message translates to:
  /// **'주문이 생성되었습니다.'**
  String get cartCheckoutSuccess;

  /// No description provided for @cartCheckoutFailed.
  ///
  /// In ko, this message translates to:
  /// **'주문 생성에 실패했습니다: {message}'**
  String cartCheckoutFailed(String message);

  /// No description provided for @cartCheckoutError.
  ///
  /// In ko, this message translates to:
  /// **'주문 중 오류가 발생했습니다: {error}'**
  String cartCheckoutError(String error);

  /// No description provided for @cartGenericError.
  ///
  /// In ko, this message translates to:
  /// **'오류가 발생했습니다.\n{error}'**
  String cartGenericError(String error);

  /// No description provided for @cartEmptyMessage.
  ///
  /// In ko, this message translates to:
  /// **'장바구니가 비었습니다.'**
  String get cartEmptyMessage;

  /// No description provided for @cartCheckoutButton.
  ///
  /// In ko, this message translates to:
  /// **'{price}원 결제하기'**
  String cartCheckoutButton(String price);

  /// No description provided for @wishlistEmpty.
  ///
  /// In ko, this message translates to:
  /// **'위시리스트에 추가된 상품이 없습니다.'**
  String get wishlistEmpty;

  /// No description provided for @wishlistNoItemsToDisplay.
  ///
  /// In ko, this message translates to:
  /// **'표시할 상품이 없습니다.'**
  String get wishlistNoItemsToDisplay;

  /// No description provided for @commonEdit.
  ///
  /// In ko, this message translates to:
  /// **'수정'**
  String get commonEdit;

  /// No description provided for @commonMore.
  ///
  /// In ko, this message translates to:
  /// **'더보기'**
  String get commonMore;

  /// No description provided for @commonCancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get commonDelete;

  /// No description provided for @commonMultiSelect.
  ///
  /// In ko, this message translates to:
  /// **'다중선택'**
  String get commonMultiSelect;

  /// No description provided for @commonSelectAll.
  ///
  /// In ko, this message translates to:
  /// **'모두 선택'**
  String get commonSelectAll;

  /// No description provided for @commonDeselectAll.
  ///
  /// In ko, this message translates to:
  /// **'전체 해제'**
  String get commonDeselectAll;

  /// No description provided for @commonDeleteSelected.
  ///
  /// In ko, this message translates to:
  /// **'선택 삭제'**
  String get commonDeleteSelected;

  /// No description provided for @commonAdminAuthFailed.
  ///
  /// In ko, this message translates to:
  /// **'관리자 인증에 실패했습니다.'**
  String get commonAdminAuthFailed;

  /// No description provided for @commonSelectItemToDelete.
  ///
  /// In ko, this message translates to:
  /// **'삭제할 항목을 선택해주세요.'**
  String get commonSelectItemToDelete;

  /// No description provided for @commonDeleteFailed.
  ///
  /// In ko, this message translates to:
  /// **'삭제에 실패했습니다: {error}'**
  String commonDeleteFailed(String error);

  /// No description provided for @productDeleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'상품 삭제'**
  String get productDeleteTitle;

  /// No description provided for @productDeleteConfirm.
  ///
  /// In ko, this message translates to:
  /// **'정말로 이 상품을 삭제하시겠습니까?'**
  String get productDeleteConfirm;

  /// No description provided for @productDeleteSuccess.
  ///
  /// In ko, this message translates to:
  /// **'상품이 삭제되었습니다.'**
  String get productDeleteSuccess;

  /// No description provided for @productBulkDeleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'상품 일괄 삭제'**
  String get productBulkDeleteTitle;

  /// No description provided for @productBulkDeleteConfirm.
  ///
  /// In ko, this message translates to:
  /// **'{count}개의 상품을 정말로 삭제하시겠습니까?'**
  String productBulkDeleteConfirm(int count);

  /// No description provided for @productBulkDeleteFailed.
  ///
  /// In ko, this message translates to:
  /// **'일부 상품 삭제에 실패했습니다.'**
  String get productBulkDeleteFailed;

  /// No description provided for @productBulkDeleteSuccess.
  ///
  /// In ko, this message translates to:
  /// **'{count}개의 상품이 삭제되었습니다.'**
  String productBulkDeleteSuccess(int count);

  /// No description provided for @productSelectedCount.
  ///
  /// In ko, this message translates to:
  /// **'선택된 상품 {count}개'**
  String productSelectedCount(int count);

  /// No description provided for @productOnSaleCount.
  ///
  /// In ko, this message translates to:
  /// **'판매중 상품 {count}개'**
  String productOnSaleCount(int count);

  /// No description provided for @fundingSelectedCount.
  ///
  /// In ko, this message translates to:
  /// **'선택된 펀딩 {count}개'**
  String fundingSelectedCount(int count);

  /// No description provided for @fundingRegisteredCount.
  ///
  /// In ko, this message translates to:
  /// **'등록된 펀딩 {count}개'**
  String fundingRegisteredCount(int count);

  /// No description provided for @categoryOuter.
  ///
  /// In ko, this message translates to:
  /// **'아우터'**
  String get categoryOuter;

  /// No description provided for @categoryOuter_coat.
  ///
  /// In ko, this message translates to:
  /// **'코트'**
  String get categoryOuter_coat;

  /// No description provided for @categoryOuter_jacket.
  ///
  /// In ko, this message translates to:
  /// **'재킷'**
  String get categoryOuter_jacket;

  /// No description provided for @categoryOuter_vest.
  ///
  /// In ko, this message translates to:
  /// **'조끼'**
  String get categoryOuter_vest;

  /// No description provided for @categoryOuter_etc.
  ///
  /// In ko, this message translates to:
  /// **'가디건 외'**
  String get categoryOuter_etc;

  /// No description provided for @categoryTop.
  ///
  /// In ko, this message translates to:
  /// **'상의'**
  String get categoryTop;

  /// No description provided for @categoryTop_sleeveless.
  ///
  /// In ko, this message translates to:
  /// **'민소매'**
  String get categoryTop_sleeveless;

  /// No description provided for @categoryTop_shortSleeve.
  ///
  /// In ko, this message translates to:
  /// **'반소매'**
  String get categoryTop_shortSleeve;

  /// No description provided for @categoryTop_longSleeve.
  ///
  /// In ko, this message translates to:
  /// **'긴소매'**
  String get categoryTop_longSleeve;

  /// No description provided for @categoryTop_shirt.
  ///
  /// In ko, this message translates to:
  /// **'셔츠'**
  String get categoryTop_shirt;

  /// No description provided for @categoryTop_etc.
  ///
  /// In ko, this message translates to:
  /// **'티셔츠 외'**
  String get categoryTop_etc;

  /// No description provided for @categoryBottom.
  ///
  /// In ko, this message translates to:
  /// **'하의'**
  String get categoryBottom;

  /// No description provided for @categoryBottom_skirt.
  ///
  /// In ko, this message translates to:
  /// **'치마'**
  String get categoryBottom_skirt;

  /// No description provided for @categoryBottom_underSkirt.
  ///
  /// In ko, this message translates to:
  /// **'속치마'**
  String get categoryBottom_underSkirt;

  /// No description provided for @categoryBottom_longSkirt.
  ///
  /// In ko, this message translates to:
  /// **'허리치마'**
  String get categoryBottom_longSkirt;

  /// No description provided for @categoryBottom_miniSkirt.
  ///
  /// In ko, this message translates to:
  /// **'미니스커트'**
  String get categoryBottom_miniSkirt;

  /// No description provided for @categoryBottom_etcSkirt.
  ///
  /// In ko, this message translates to:
  /// **'기타 치마'**
  String get categoryBottom_etcSkirt;

  /// No description provided for @categoryBottom_pants.
  ///
  /// In ko, this message translates to:
  /// **'바지'**
  String get categoryBottom_pants;

  /// No description provided for @categoryBottom_underPants.
  ///
  /// In ko, this message translates to:
  /// **'속바지'**
  String get categoryBottom_underPants;

  /// No description provided for @categoryBottom_shortPants.
  ///
  /// In ko, this message translates to:
  /// **'반바지'**
  String get categoryBottom_shortPants;

  /// No description provided for @categoryBottom_longPants.
  ///
  /// In ko, this message translates to:
  /// **'긴바지'**
  String get categoryBottom_longPants;

  /// No description provided for @categoryBottom_etcPants.
  ///
  /// In ko, this message translates to:
  /// **'기타 바지'**
  String get categoryBottom_etcPants;

  /// No description provided for @categoryGoods.
  ///
  /// In ko, this message translates to:
  /// **'잡화'**
  String get categoryGoods;

  /// No description provided for @categoryGoods_head.
  ///
  /// In ko, this message translates to:
  /// **'머리장식'**
  String get categoryGoods_head;

  /// No description provided for @categoryGoods_norigae.
  ///
  /// In ko, this message translates to:
  /// **'노리개'**
  String get categoryGoods_norigae;

  /// No description provided for @categoryGoods_bag.
  ///
  /// In ko, this message translates to:
  /// **'가방'**
  String get categoryGoods_bag;

  /// No description provided for @categoryGoods_neck.
  ///
  /// In ko, this message translates to:
  /// **'목걸이'**
  String get categoryGoods_neck;

  /// No description provided for @categoryGoods_ear.
  ///
  /// In ko, this message translates to:
  /// **'귀걸이'**
  String get categoryGoods_ear;

  /// No description provided for @categoryGoods_ring.
  ///
  /// In ko, this message translates to:
  /// **'반지'**
  String get categoryGoods_ring;

  /// No description provided for @categoryGoods_etc.
  ///
  /// In ko, this message translates to:
  /// **'기타 잡화'**
  String get categoryGoods_etc;

  /// No description provided for @currencyFormat.
  ///
  /// In ko, this message translates to:
  /// **'{price}원'**
  String currencyFormat(String price);

  /// No description provided for @dummyImage.
  ///
  /// In ko, this message translates to:
  /// **'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg'**
  String get dummyImage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
