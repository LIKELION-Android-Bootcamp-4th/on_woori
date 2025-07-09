import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:on_woori/main.dart' as app;
import 'package:on_woori/widgets/products_double_grid.dart';
import 'package:on_woori/widgets/funding_list_item.dart';
import 'package:on_woori/widgets/brand_grid_item.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HomePage 통합 테스트', () {
    testWidgets('HomePage가 로딩 후 모든 섹션을 올바르게 표시하는지 검증',
            (WidgetTester tester) async {

          // 1. 앱을 실행합니다.
          app.main();

          // 2. 초기 로딩 상태(CircularProgressIndicator)를 검증합니다.
          // pump()는 한 프레임을 렌더링합니다.
          await tester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          print('- 초기 로딩 인디케이터가 표시되는 것을 확인했습니다.');

          // 3. initState의 모든 비동기 작업(로그인, API 3개 호출)이 끝날 때까지 기다립니다.
          // pumpAndSettle은 위젯 트리가 안정될 때까지 프레임을 계속 펌핑합니다.
          // 여러 API를 호출하므로 타임아웃을 넉넉하게 줍니다.
          await tester.pumpAndSettle(const Duration(seconds: 10));
          print('- 모든 API 데이터 로딩을 대기했습니다.');

          // 4. 로딩이 끝난 후, 로딩 인디케이터가 사라졌는지 확인합니다.
          expect(find.byType(CircularProgressIndicator), findsNothing);
          print('- 로딩 인디케이터가 사라진 것을 확인했습니다.');

          // 5. 각 섹션의 제목들이 화면에 보이는지 확인합니다.
          // l10n 라이브러리에 따라 실제 표시되는 텍스트로 검증해야 합니다.
          expect(find.text('추천 상품'), findsOneWidget);
          expect(find.text('진행중인 펀딩'), findsOneWidget);
          expect(find.text('브랜드 둘러보기'), findsOneWidget);
          print('- 각 섹션의 제목이 올바르게 표시되었습니다.');

          // 6. 각 섹션의 결과 위젯들이 존재하는지 확인합니다.
          // API 응답에 따라 아이템이 1개 이상일 수 있으므로 findsWidgets를 사용합니다.
          expect(find.byType(ProductsNonScrollableGrid), findsOneWidget);
          expect(find.byType(FundingListItem), findsWidgets);
          expect(find.byType(BrandGridItem), findsWidgets);
          print('- 각 섹션의 리스트/그리드가 정상적으로 렌더링되었습니다.');

          print('HomePage UI 테스트 성공!');
        });
  });
}