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
  String get mainSlogan => '나를 위한 오늘의 한복';

  @override
  String get bottomNavigationBarHome => '홈';

  @override
  String get bottomNavigationBarCategory => '카테고리';

  @override
  String get bottomNavigationBarWish => '위시리스트';

  @override
  String get bottomNavigationBarMyPage => '마이페이지';

  @override
  String get loginTitle => '로그인';

  @override
  String get loginEmailTitle => '이메일';

  @override
  String get loginEmailInputHint => '이메일 주소를 입력하세요';

  @override
  String get loginPasswordTitle => '비밀번호';

  @override
  String get loginPasswordInputHint => '비밀번호를 입력하세요';

  @override
  String get loginPasswordReset => '비밀번호 재설정';

  @override
  String get loginSubmitButton => '로그인';

  @override
  String get signInTitle => '회원가입';

  @override
  String get signInSubtitle => '어떤 사용자인가요?';

  @override
  String get signInUserTypeConsumer => '구매자';

  @override
  String get signInUserTypeSeller => '판매자';
}
