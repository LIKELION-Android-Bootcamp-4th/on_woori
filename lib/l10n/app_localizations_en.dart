// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'On-Woori';

  @override
  String get navBarHome => 'Home';

  @override
  String get navBarCategory => 'Category';

  @override
  String get navBarWish => 'Wishlist';

  @override
  String get navBarMyPage => 'My Page';

  @override
  String get homeSlogan => 'Today\'s Hanbok for Me';

  @override
  String get homeRecommendedProducts => 'Recommended Products';

  @override
  String get homeOngoingFunding => 'Ongoing Funding';

  @override
  String get homeBrandList => 'Browse Brands';

  @override
  String homePageError(String error) {
    return 'Error: $error';
  }

  @override
  String get homePageNoData => 'No data available.';

  @override
  String get homePageNoBrand => 'No Brand';

  @override
  String get loginPageTitle => 'Login';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailHint => 'Enter your email address';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginPasswordReset => 'Reset Password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginPromptSignUp => 'First time here? ';

  @override
  String get loginSuccess => 'Logged in successfully.';

  @override
  String get loginErrorBadRequest => 'Invalid request.';

  @override
  String get loginErrorUnauthorized => 'Incorrect email or password.';

  @override
  String get loginErrorForbidden => 'Account is disabled or not verified.';

  @override
  String get loginErrorServer =>
      'A server error occurred. Please try again later.';

  @override
  String get loginErrorUnexpected => 'An unexpected error occurred.';

  @override
  String get signUpPageTitle => 'Sign Up';

  @override
  String get signUpPageSubtitle => 'What type of user are you?';

  @override
  String get signUpPageSubtitleCommon => 'Common';

  @override
  String get signUpUserTypeConsumer => 'Buyer';

  @override
  String get signUpUserTypeSeller => 'Seller';

  @override
  String get signUpSuccess => 'Sign-up and login successful.';

  @override
  String get signUpErrorServer =>
      'A server error occurred. Please try again later.';

  @override
  String get signUpErrorBadRequest => 'Please check your input.';

  @override
  String get signUpErrorConflict => 'This email is already registered.';

  @override
  String get signUpErrorUnexpected =>
      'An unknown error occurred. Please contact support.';

  @override
  String get signUpNicknameLabel => 'Nickname';

  @override
  String get signUpNicknameHint => 'Enter your nickname';

  @override
  String get signUpPasswordLabel => 'Password';

  @override
  String get signUpPasswordHint => 'Enter your password';

  @override
  String get signUpPasswordConfirmLabel => 'Confirm Password';

  @override
  String get signUpPasswordConfirmHint => 'Enter your password again';

  @override
  String get validatorRequired => 'This field is required';

  @override
  String get validatorPasswordMismatch => 'Passwords do not match';

  @override
  String get validatorPasswordInvalid =>
      'Must be 8+ characters with uppercase, lowercase, number, and special character.';

  @override
  String get validatorEmailInvalid => 'Invalid email format.';

  @override
  String get passwordEditPageTitle => 'Edit Password';

  @override
  String get passwordEditCurrentPasswordLabel => 'Current Password';

  @override
  String get passwordEditNewPasswordLabel => 'New Password';

  @override
  String get passwordEditConfirmPasswordLabel => 'Confirm Password';

  @override
  String get passwordEditHint => 'Enter password';

  @override
  String get passwordEditButton => 'Change Password';

  @override
  String get passwordEditErrorLength =>
      'New password must be at least 6 characters long.';

  @override
  String get passwordEditErrorSameAsCurrent =>
      'New password must be different from the current one.';

  @override
  String get passwordEditErrorMismatch => 'New passwords do not match.';

  @override
  String get passwordEditErrorInvalidUser => 'Invalid user information.';

  @override
  String get passwordEditSuccess => 'Password changed successfully.';

  @override
  String get passwordEditErrorFailed =>
      'Failed to change password. Please try again.';

  @override
  String get passwordEditErrorUnexpected => 'An unknown error occurred.';

  @override
  String get editProfilePageTitle => 'Edit Profile';

  @override
  String get editProfileCamera => 'Take a photo';

  @override
  String get editProfileGallery => 'Choose from gallery';

  @override
  String get editProfileNicknameLabel => 'Nickname';

  @override
  String get editProfileNicknameHint => 'Enter your nickname';

  @override
  String get editProfileSaveButton => 'Save';

  @override
  String get editProfileImagePicking => 'Already picking an image.';

  @override
  String get editProfileSellerPageTitle => 'Edit Profile';

  @override
  String get editProfileSellerManagerLabel => 'Manager Name';

  @override
  String get editProfileSellerManagerHint => 'Enter manager\'s name';

  @override
  String get editProfileSellerPhoneLabel => 'Phone Number';

  @override
  String get editProfileSellerPhoneHint => 'Enter phone number';

  @override
  String get editProfileSellerZipcodeLabel => 'Zip Code';

  @override
  String get editProfileSellerZipcodeHint => 'Enter zip code';

  @override
  String get editProfileSellerZipcodeInvalid => 'Zip code must be 5 digits.';

  @override
  String get editProfileSellerAddressLabel => 'Address';

  @override
  String get editProfileSellerAddressHint => 'Enter address';

  @override
  String get editProfileSellerDetailAddressLabel => 'Detailed Address';

  @override
  String get editProfileSellerDetailAddressHint => 'Enter detailed address';

  @override
  String get editProfileSellerSaveButton => 'Save';

  @override
  String get brandEditPageTitle => 'Edit Brand';

  @override
  String get brandEditImagePicking => 'Already picking an image.';

  @override
  String get brandEditCamera => 'Take a photo';

  @override
  String get brandEditGallery => 'Choose from gallery';

  @override
  String brandEditUpdateFailed(String error) {
    return 'Update failed: $error';
  }

  @override
  String brandEditFetchError(String error) {
    return 'Error: $error';
  }

  @override
  String get brandEditNoData => 'No data available.';

  @override
  String get brandEditNameLabel => 'Brand Name';

  @override
  String get brandEditNameHint => '(Name)';

  @override
  String get brandEditDescriptionLabel => 'Brand Introduction';

  @override
  String get brandEditDescriptionHint => '(Introduction) (max nn chars)';

  @override
  String get brandEditSaveButton => 'Save';

  @override
  String get myPageDefaultUserName => 'User';

  @override
  String get myPageUserSuffix => '';

  @override
  String get myPageSellerSuffix => '(Seller)';

  @override
  String get myPageProfileEditButton => 'Edit Profile';

  @override
  String get myPageBrandEditButton => 'Edit Brand';

  @override
  String get myPageSectionShopping => 'Shopping';

  @override
  String get myPageSectionOrder => 'Orders';

  @override
  String get myPageOrderHistory => 'Order History';

  @override
  String get myPageWishlist => 'Wishlist';

  @override
  String get myPageSectionMyInfo => 'My Info';

  @override
  String get myPageChangePassword => 'Change Password';

  @override
  String get myPageRegisterProduct => 'Register Product';

  @override
  String get myPageRegisterFunding => 'Register Funding';

  @override
  String get myPageManageItems => 'Manage Items/Fundings';

  @override
  String get myPageLogout => 'Logout';

  @override
  String get myPageLogoutSuccess => 'Logged out successfully.';

  @override
  String myPageLogoutFailed(String message) {
    return 'Logout failed: $message';
  }

  @override
  String myPageLogoutError(String error) {
    return 'Error during logout: $error';
  }

  @override
  String get myPageNoData => 'No data available.';

  @override
  String get productRegisterPageTitle => 'Register New Product';

  @override
  String get productRegisterThumbnailImageLabel => 'Thumbnail Image';

  @override
  String get productRegisterNameLabel => 'Product Name';

  @override
  String get productRegisterNameHint => '(Name)';

  @override
  String get productRegisterPriceLabel => 'Product Price (Original)';

  @override
  String get productRegisterPriceHint => '200.00';

  @override
  String get productRegisterDiscountLabel => 'Discount Rate (0% if blank)';

  @override
  String get productRegisterDiscountHint => 'Ex: 10';

  @override
  String get productRegisterDisplayPriceLabel =>
      'Display Price (After Discount)';

  @override
  String get productRegisterDisplayPriceHint => 'Ex: 180.00';

  @override
  String get productRegisterDescriptionLabel => 'Product Description';

  @override
  String get productRegisterDescriptionHint => '(Description)';

  @override
  String get productRegisterSizeOptionLabel => 'Size Options';

  @override
  String get productRegisterCategoryLabel => 'Category';

  @override
  String get productRegisterDetailImageLabel => 'Product Images (Optional)';

  @override
  String get productRegisterButton => 'Register Product';

  @override
  String get productRegisterAddDetailImage => 'Add Detail Images';

  @override
  String get productRegisterErrorMaxImages =>
      'You can register up to 5 images.';

  @override
  String get productRegisterErrorNoThumbnail =>
      'Please register a thumbnail image.';

  @override
  String get productRegisterErrorNoNamePrice =>
      'Product name and price are required.';

  @override
  String get productRegisterErrorNoSize =>
      'Please select at least one size option.';

  @override
  String productRegisterErrorImageUploadFailed(String message) {
    return 'Failed to upload detail images: $message';
  }

  @override
  String get productRegisterErrorLength =>
      'Product name must be at least 2 characters long.';

  @override
  String get productRegisterSuccess => 'Product registered successfully.';

  @override
  String productRegisterErrorFailed(String message) {
    return 'Failed to register product: $message';
  }

  @override
  String productRegisterErrorUnexpected(String error) {
    return 'An error occurred during product registration: $error';
  }

  @override
  String get productEditPageTitle => 'Edit Product';

  @override
  String get productEditButton => 'Update Product';

  @override
  String productEditFetchError(String error) {
    return 'Failed to load product information: $error';
  }

  @override
  String get productEditSuccess => 'Product updated successfully.';

  @override
  String productEditErrorUpdateFailed(String error) {
    return 'An error occurred while updating the product: $error';
  }

  @override
  String get fundingRegisterPageTitle => 'Register New Funding';

  @override
  String get fundingRegisterCamera => 'Take a photo';

  @override
  String get fundingRegisterGallery => 'Choose from gallery';

  @override
  String get fundingRegisterThumbnailLabel => 'Thumbnail Image';

  @override
  String get fundingRegisterNameLabel => 'Funding Name';

  @override
  String get fundingRegisterNameHint => '(Name)';

  @override
  String get fundingRegisterLinkLabel => 'Funding Link';

  @override
  String get fundingRegisterLinkHint => 'https://www.';

  @override
  String get fundingRegisterButton => 'Add Funding';

  @override
  String productListPageError(String error) {
    return 'Error: $error';
  }

  @override
  String get productListPageNoData => 'No data available.';

  @override
  String get productListPageEmpty => 'No products to display.';

  @override
  String productListPageProcessingError(String error) {
    return 'An error occurred while processing data: $error';
  }

  @override
  String get productDetailPageTitle => 'Product Details';

  @override
  String get productDetailTotalPrice => 'Total Amount';

  @override
  String get productDetailAddToCartButton => 'Add to Cart';

  @override
  String get productDetailOrderButton => 'Order Now';

  @override
  String get productDetailLoginRequiredTitle => 'Login Required';

  @override
  String get productDetailLoginRequiredContent =>
      'This feature requires login. Would you like to go to the login page?';

  @override
  String get productDetailToggleFavoriteError =>
      'An error occurred. Please try again.';

  @override
  String get productDetailSelectSizePrompt => 'Please select a size.';

  @override
  String get productDetailSelectColorPrompt => 'Please select a color.';

  @override
  String get productDetailAddToCartSuccess => 'Added to cart.';

  @override
  String productDetailAddToCartFailed(String error) {
    return 'Failed to add to cart: $error';
  }

  @override
  String productDetailAddToCartError(String error) {
    return 'An error occurred: $error';
  }

  @override
  String productDetailFetchError(String error) {
    return 'Error: $error';
  }

  @override
  String get productDetailNoData => 'Product information not found.';

  @override
  String get productDetailNoBrand => 'No brand information';

  @override
  String get productDetailDefaultCategory => 'Category';

  @override
  String get productDetailSizeDropdownHint => 'Select Size';

  @override
  String get productDetailColorDropdownHint => 'Select Color';

  @override
  String productDetailSelectedOptionSize(String size) {
    return 'Size: $size';
  }

  @override
  String productDetailSelectedOptionColor(String color) {
    return 'Color: $color';
  }

  @override
  String productDetailDiscountPercent(String rate) {
    return '$rate% OFF';
  }

  @override
  String get orderDetailPageTitle => 'Order Details';

  @override
  String orderDetailPageError(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get orderDetailPageNoData => 'Order information not found.';

  @override
  String get orderDetailSectionProducts => 'Ordered Products';

  @override
  String get orderDetailSectionPayment => 'Payment Information';

  @override
  String orderDetailHeaderNumber(String orderNumber) {
    return 'Order No. $orderNumber';
  }

  @override
  String orderDetailProductOptions(String options, int quantity) {
    return '$options | Qty: $quantity';
  }

  @override
  String get orderDetailTotalProductAmount => 'Total Product Amount';

  @override
  String get orderDetailShippingFee => 'Total Shipping Fee';

  @override
  String get orderDetailTotalPayment => 'Total Payment';

  @override
  String get productManagementPageTitle => 'Product Management';

  @override
  String get productManagementProductTab => 'Products';

  @override
  String get productManagementFundingTab => 'Fundings';

  @override
  String brandDetailPageError(String error) {
    return 'Error: $error';
  }

  @override
  String get brandDetailPageNoData => 'No data available.';

  @override
  String get brandDetailDefaultName => 'Brand Name';

  @override
  String get brandDetailDefaultDescription => 'Brand Introduction';

  @override
  String get brandDetailProductsError => 'Failed to load products.';

  @override
  String get brandDetailProductsNoData => 'No product data.';

  @override
  String get brandDetailNoRecommendedProducts => 'No recommended products.';

  @override
  String get brandDetailNoOngoingFunding => 'No ongoing fundings.';

  @override
  String get cartPageTitle => 'Cart';

  @override
  String get cartItemDeletedSuccess => 'Item removed from cart.';

  @override
  String cartItemDeleteFailed(String error) {
    return 'Failed to remove item: $error';
  }

  @override
  String get cartEmptyError => 'No items in cart.';

  @override
  String get cartCheckoutSuccess => 'Order created successfully.';

  @override
  String cartCheckoutFailed(String message) {
    return 'Failed to create order: $message';
  }

  @override
  String cartCheckoutError(String error) {
    return 'An error occurred during checkout: $error';
  }

  @override
  String cartGenericError(String error) {
    return 'An error occurred.\n$error';
  }

  @override
  String get cartEmptyMessage => 'Your cart is empty.';

  @override
  String cartCheckoutButton(String price) {
    return 'Checkout for \$$price';
  }

  @override
  String get wishlistEmpty => 'No items in your wishlist.';

  @override
  String get wishlistNoItemsToDisplay => 'No products to display.';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonMore => 'More';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonMultiSelect => 'Multi-select';

  @override
  String get commonSelectAll => 'Select All';

  @override
  String get commonDeselectAll => 'Deselect All';

  @override
  String get commonDeleteSelected => 'Delete Selected';

  @override
  String get commonAdminAuthFailed => 'Admin authentication failed.';

  @override
  String get commonSelectItemToDelete => 'Please select items to delete.';

  @override
  String commonDeleteFailed(String error) {
    return 'Failed to delete: $error';
  }

  @override
  String get productDeleteTitle => 'Delete Product';

  @override
  String get productDeleteConfirm =>
      'Are you sure you want to delete this product?';

  @override
  String get productDeleteSuccess => 'Product deleted successfully.';

  @override
  String get productBulkDeleteTitle => 'Bulk Delete Products';

  @override
  String productBulkDeleteConfirm(int count) {
    return 'Are you sure you want to delete $count products?';
  }

  @override
  String get productBulkDeleteFailed => 'Failed to delete some products.';

  @override
  String productBulkDeleteSuccess(int count) {
    return '$count products have been deleted.';
  }

  @override
  String productSelectedCount(int count) {
    return '$count products selected';
  }

  @override
  String productOnSaleCount(int count) {
    return '$count products on sale';
  }

  @override
  String fundingSelectedCount(int count) {
    return '$count fundings selected';
  }

  @override
  String fundingRegisteredCount(int count) {
    return '$count fundings registered';
  }

  @override
  String get categoryOuter => 'Outerwear';

  @override
  String get categoryOuter_coat => 'Coat';

  @override
  String get categoryOuter_jacket => 'Jacket';

  @override
  String get categoryOuter_vest => 'Vest';

  @override
  String get categoryOuter_etc => 'Cardigan, etc.';

  @override
  String get categoryTop => 'Tops';

  @override
  String get categoryTop_sleeveless => 'Sleeveless';

  @override
  String get categoryTop_shortSleeve => 'Short Sleeve';

  @override
  String get categoryTop_longSleeve => 'Long Sleeve';

  @override
  String get categoryTop_shirt => 'Shirt';

  @override
  String get categoryTop_etc => 'T-shirt, etc.';

  @override
  String get categoryBottom => 'Bottoms';

  @override
  String get categoryBottom_skirt => 'Skirt';

  @override
  String get categoryBottom_underSkirt => 'Underskirt';

  @override
  String get categoryBottom_longSkirt => 'Long Skirt';

  @override
  String get categoryBottom_miniSkirt => 'Mini Skirt';

  @override
  String get categoryBottom_etcSkirt => 'Other Skirts';

  @override
  String get categoryBottom_pants => 'Pants';

  @override
  String get categoryBottom_underPants => 'Underpants';

  @override
  String get categoryBottom_shortPants => 'Shorts';

  @override
  String get categoryBottom_longPants => 'Long Pants';

  @override
  String get categoryBottom_etcPants => 'Other Pants';

  @override
  String get categoryGoods => 'Accessories';

  @override
  String get categoryGoods_head => 'Headwear';

  @override
  String get categoryGoods_norigae => 'Norigae';

  @override
  String get categoryGoods_bag => 'Bag';

  @override
  String get categoryGoods_neck => 'Necklace';

  @override
  String get categoryGoods_ear => 'Earrings';

  @override
  String get categoryGoods_ring => 'Ring';

  @override
  String get categoryGoods_etc => 'Other Goods';

  @override
  String currencyFormat(String price) {
    return '\$$price';
  }

  @override
  String get dummyImage =>
      'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg';
}
