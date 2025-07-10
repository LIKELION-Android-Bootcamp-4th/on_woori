import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:on_woori/core/router.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/app_bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ko'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({
    super.key,
    required this.child,
  });

  // 현재 경로(location)를 기반으로 BottomNavigationBar의 인덱스를 계산하는 함수
  int _locationToTabIndex(String location) {
    if (location.startsWith('/category')) {
      return 1;
    } else if (location.startsWith('/wish')) {
      return 2;
    } else if (location.startsWith('/mypage')) { // '/mypage'와 '/mypage/seller' 모두 3번 탭으로 인식
      return 3;
    } else {
      return 0; // 그 외 모든 경로는 홈(0번 탭)으로 간주
    }
  }

  void _navigateToMyPageBasedOnRole(BuildContext context) async {
    const storage = FlutterSecureStorage();
    final userRole = await storage.read(key: 'USER_ROLE');

    if (userRole == 'seller') {
      context.go('/mypage/seller');
    } else {
      context.go('/mypage');
    }
  }
  // ---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: _locationToTabIndex(GoRouterState.of(context).uri.toString()),
        onItemTapped: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/category');
              break;
            case 2:
              context.go('/wish');
              break;
            case 3:
              _navigateToMyPageBasedOnRole(context);
              break;
          }
        },
      ),
    );
  }
}
