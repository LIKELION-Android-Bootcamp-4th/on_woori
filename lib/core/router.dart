import 'package:go_router/go_router.dart';
import 'package:on_woori/main.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/', // 앱의 진입점
      builder: (context, state) {
        // 이 경로로 오면 MyHomePage을 보여줌
        return const MyHomePage();
      },
    ),
  ],
);