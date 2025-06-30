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

  /// No description provided for @mainSlogan.
  ///
  /// In ko, this message translates to:
  /// **'나를 위한 오늘의 한복'**
  String get mainSlogan;

  /// No description provided for @bottomNavigationBarHome.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get bottomNavigationBarHome;

  /// No description provided for @bottomNavigationBarCategory.
  ///
  /// In ko, this message translates to:
  /// **'카테고리'**
  String get bottomNavigationBarCategory;

  /// No description provided for @bottomNavigationBarWish.
  ///
  /// In ko, this message translates to:
  /// **'위시리스트'**
  String get bottomNavigationBarWish;

  /// No description provided for @bottomNavigationBarMyPage.
  ///
  /// In ko, this message translates to:
  /// **'마이페이지'**
  String get bottomNavigationBarMyPage;

  /// No description provided for @loginTitle.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get loginTitle;

  /// No description provided for @loginEmailTitle.
  ///
  /// In ko, this message translates to:
  /// **'이메일'**
  String get loginEmailTitle;

  /// No description provided for @loginEmailInputHint.
  ///
  /// In ko, this message translates to:
  /// **'이메일 주소를 입력하세요'**
  String get loginEmailInputHint;

  /// No description provided for @loginPasswordTitle.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호'**
  String get loginPasswordTitle;

  /// No description provided for @loginPasswordInputHint.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호를 입력하세요'**
  String get loginPasswordInputHint;

  /// No description provided for @loginPasswordReset.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 재설정'**
  String get loginPasswordReset;

  /// No description provided for @loginSubmitButton.
  ///
  /// In ko, this message translates to:
  /// **'로그인'**
  String get loginSubmitButton;

  /// No description provided for @signInTitle.
  ///
  /// In ko, this message translates to:
  /// **'회원가입'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'어떤 사용자인가요?'**
  String get signInSubtitle;

  /// No description provided for @signInUserTypeConsumer.
  ///
  /// In ko, this message translates to:
  /// **'구매자'**
  String get signInUserTypeConsumer;

  /// No description provided for @signInUserTypeSeller.
  ///
  /// In ko, this message translates to:
  /// **'판매자'**
  String get signInUserTypeSeller;
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
