import 'package:go_router/go_router.dart';

import 'package:on_woori/main.dart';
import 'package:on_woori/ui/cart/cart.dart';
import 'package:on_woori/ui/category/category.dart';
import 'package:on_woori/ui/home/home.dart';
import 'package:on_woori/ui/mypage_seller/mypage_seller.dart';
import 'package:on_woori/ui/products/products_detail.dart';
import 'package:on_woori/ui/products/products_list.dart';
import 'package:on_woori/ui/wish/wish.dart';
import 'package:on_woori/ui/order/order_detail_page.dart';
import 'package:on_woori/ui/mypage/editprofile/editprofile.dart';
import 'package:on_woori/ui/mypage/change-password.dart';

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
            return const SellerMyPage();
          },
        ),
        GoRoute(
          path: '/orderdetail',
          builder: (context, state) {
            return const OrderDetailPage();
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
            path: '/productdetail/:productId',
            builder: (context, state) {
              final String productId = state.pathParameters['productId'] ?? "";
              return ProductsDetailPage(productId);
            },
        ),
        GoRoute(
          path: '/wish/cart',
          builder: (context, state) {
            return const CartPage();
          },
        ),

        GoRoute(
          path: '/mypage/password',
          builder: (context, state) {
            return const PasswordEditPage();
          },
        ),
      ],
    ),
  ],
);