import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:on_woori/main.dart' as app;
import 'package:on_woori/ui/auth/login/login_page.dart';
import 'package:on_woori/ui/cart/cart.dart';
import 'package:on_woori/ui/mypage/change-password.dart';
import 'package:on_woori/ui/mypage/editprofile/editprofile.dart';
import 'package:on_woori/ui/mypage/mypage.dart';
import 'package:on_woori/ui/order/order_list.dart';
import 'package:on_woori/ui/wish/wish.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('마이페이지 화면 이동 통합 테스트', () {
    testWidgets('자동 로그인 후 마이페이지 내 모든 메뉴 이동 및 로그아웃까지 검증', (WidgetTester tester) async {
      // --- 1단계: 앱 실행 ---
      app.main();
      print('✅ 1. 앱 실행 시작');

      // --- 2단계: 자동 로그인 및 데이터 로딩 대기 ---
      await tester.pumpAndSettle(const Duration(seconds: 10));
      print('✅ 2. 자동 로그인 및 홈 화면 로딩 완료');

      // --- 3단계: 마이페이지로 이동 ---
      await tester.tap(find.text('마이페이지'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // MyPage 위젯이 화면에 보이는지 확인
      expect(find.byType(MyPage), findsOneWidget, reason: '마이페이지로 이동해야 합니다.');
      print('✅ 3. 마이페이지 탭으로 전환 성공');

      // --- 4단계: 마이페이지 내 기능별 화면 이동 테스트 ---

      // 4-1. 장바구니 페이지 이동 테스트
      print('  ➡️ 4-1. 장바구니 페이지 이동 테스트 시작');
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(CartPage), findsOneWidget);
      await tester.pageBack(); // 뒤로가기
      await tester.pumpAndSettle();
      expect(find.byType(MyPage), findsOneWidget);
      print('  ✅ 4-1. 장바구니 페이지 이동 및 복귀 완료');

      // 4-2. 프로필 수정 페이지 이동 테스트
      print('  ➡️ 4-2. 프로필 수정 페이지 이동 테스트 시작');
      await tester.tap(find.text('프로필 수정'));
      await tester.pumpAndSettle();
      expect(find.byType(EditProfilePage), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(MyPage), findsOneWidget);
      print('  ✅ 4-2. 프로필 수정 페이지 이동 및 복귀 완료');

      // 4-3. 주문 내역 페이지 이동 테스트
      print('  ➡️ 4-3. 주문 내역 페이지 이동 테스트 시작');
      await tester.tap(find.text('주문 내역'));
      await tester.pumpAndSettle();
      expect(find.byType(OrderListPage), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(MyPage), findsOneWidget);
      print('  ✅ 4-3. 주문 내역 페이지 이동 및 복귀 완료');

      // 4-4. 위시리스트 페이지 이동 테스트
      print('  ➡️ 4-4. 위시리스트 페이지 이동 테스트 시작');
      await tester.tap(find.text('위시리스트'));
      await tester.pumpAndSettle();
      expect(find.byType(WishPage), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(MyPage), findsOneWidget);
      print('  ✅ 4-4. 위시리스트 페이지 이동 및 복귀 완료');

      // 4-5. 비밀번호 변경 페이지 이동 테스트
      print('  ➡️ 4-5. 비밀번호 변경 페이지 이동 테스트 시작');
      await tester.tap(find.text('비밀번호 변경'));
      await tester.pumpAndSettle();
      expect(find.byType(PasswordEditPage), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(MyPage), findsOneWidget);
      print('  ✅ 4-5. 비밀번호 변경 페이지 이동 및 복귀 완료');

      // --- 5단계: 로그아웃 테스트 ---
      print('  ➡️ 5. 로그아웃 테스트 시작');
      await tester.tap(find.text('로그아웃'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 로그아웃 후 로그인 페이지로 이동했는지 확인
      expect(find.byType(LoginPage), findsOneWidget);
      print('✅ 5. 로그아웃 성공 및 로그인 페이지로 복귀. 전체 테스트 완료!');
    });
  });
}
