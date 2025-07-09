import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:on_woori/main.dart' as app;
import 'package:on_woori/ui/category/category.dart';
import 'package:on_woori/ui/home/home.dart';
import 'package:on_woori/ui/mypage/mypage.dart';
import 'package:on_woori/ui/wish/wish.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('바텀 네비게이션 화면 전환 테스트', () {
    testWidgets('탭 라우팅 검증',
            (WidgetTester tester) async {

          // --- 1단계: 앱 실행 및 홈 화면 로딩 ---
          app.main();
          await tester.pumpAndSettle(const Duration(seconds: 10));
          print('✅ 1. 홈 화면 로딩 완료');
          // 초기 화면이 HomePage인지 확인
          expect(find.byType(HomePage), findsOneWidget);

          // --- 2단계: 카테고리 탭 테스트 ---
          await tester.tap(find.text('카테고리'));
          await tester.pumpAndSettle();

          // CategoryPage 위젯이 화면에 보이는지 확인합니다.
          expect(find.byType(CategoryPage), findsOneWidget, reason: '카테고리 페이지로 이동해야 합니다.');
          print('✅ 2. 카테고리 탭으로 전환 성공');

          // --- 3단계: 위시리스트 탭 테스트 ---
          await tester.tap(find.text('위시리스트'));
          await tester.pumpAndSettle();

          // WishPage 위젯이 화면에 보이는지 확인합니다.
          expect(find.byType(WishPage), findsOneWidget, reason: '위시리스트 페이지로 이동해야 합니다.');
          print('✅ 3. 위시리스트 탭으로 전환 성공');

          // --- 4단계: 마이페이지 탭 테스트 ---
          await tester.tap(find.text('마이페이지'));
          await tester.pumpAndSettle();

          // MyPage 위젯이 화면에 보이는지 확인합니다.
          expect(find.byType(MyPage), findsOneWidget, reason: '마이페이지로 이동해야 합니다.');
          print('✅ 4. 마이페이지 탭으로 전환 성공');

          // --- 5단계: 다시 홈 탭으로 복귀 테스트 ---
          await tester.tap(find.text('홈'));
          await tester.pumpAndSettle();

          // HomePage 위젯이 다시 화면에 보이는지 확인합니다.
          expect(find.byType(HomePage), findsOneWidget, reason: '홈 페이지로 복귀해야 합니다.');
          print('✅ 5. 홈 탭으로 복귀 성공. 테스트 완료!');
        });
  });
}