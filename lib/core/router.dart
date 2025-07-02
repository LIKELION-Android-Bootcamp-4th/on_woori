import 'package:go_router/go_router.dart';

import 'package:on_woori/main.dart';
import 'package:on_woori/ui/cart/cart.dart';
import 'package:on_woori/ui/category/category.dart';
import 'package:on_woori/ui/home/home.dart';
import 'package:on_woori/ui/mypage/mypage.dart';
import 'package:on_woori/ui/products/products_detail.dart';
import 'package:on_woori/ui/products/products_list.dart';
import 'package:on_woori/ui/wish/wish.dart';
import 'package:on_woori/ui/mypage/editprofile/editprofile.dart';



final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    // 최상위 앱의 진입점
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child);
      },

      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/category',
          builder: (context, state) {
            return const CategoryPage();
          },
        ),
        GoRoute(
          path: '/wish',
          builder: (context, state) {
            return const WishPage();
          },
        ),
        GoRoute(
          path: '/mypage',
          builder: (context, state) {
            return const MyPage();
          },
        ),
        GoRoute(
          path: '/mypage/edit',
          builder: (context, state) {
            return const EditProfilePage();
          },
        ),
        GoRoute(
            path: '/productslist/:categoryId',
            builder: (context, state) {
              final String categoryId = state.pathParameters['categoryId'] ?? "";
              return ProductsListPage(categoryId: categoryId);
            },
        ),

        GoRoute(
            path: '/productdetail',
            builder: (context, state) {
              return ProductsDetailPage();
            },
        ),
        GoRoute(
          path: '/wish/cart',
          builder: (context, state) {
            return const CartPage();
          },
        ),
      ],
    ),
  ],
);