import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/main.dart';

import 'package:on_woori/ui/auth/login/login_page.dart';
import 'package:on_woori/ui/auth/signup/common_signup_page.dart';
import 'package:on_woori/ui/auth/signup/completed_signup_page.dart';
import 'package:on_woori/ui/auth/signup/seller_signup_page.dart';
import 'package:on_woori/ui/auth/signup/user_role_selection_page.dart';
import 'package:on_woori/ui/brand/brand_detail.dart';
import 'package:on_woori/ui/brand/brand_product_edit.dart';
import 'package:on_woori/ui/cart/cart.dart';
import 'package:on_woori/ui/category/category.dart';
import 'package:on_woori/ui/home/home.dart';
import 'package:on_woori/ui/mypage/change-password.dart';
import 'package:on_woori/ui/mypage/editprofile/editprofile.dart';
import 'package:on_woori/ui/mypage/mypage.dart';
import 'package:on_woori/ui/mypage_seller/add_funding.dart';
import 'package:on_woori/ui/mypage_seller/edit_brand.dart';
import 'package:on_woori/ui/mypage_seller/funding_edit_page.dart';
import 'package:on_woori/ui/mypage_seller/mypage_seller.dart';
import 'package:on_woori/ui/mypage_seller/product_register.dart';
import 'package:on_woori/ui/order/order_detail_page.dart';
import 'package:on_woori/ui/order/order_list.dart';
import 'package:on_woori/ui/products/product_edit.dart';
import 'package:on_woori/ui/products/products_detail.dart';
import 'package:on_woori/ui/products/products_list.dart';
import 'package:on_woori/ui/wish/wish.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> get isLoggedIn async {
    final String? token = await _storage.read(key: 'ACCESS_TOKEN');
    return token != null;
  }
}

final AuthService authService = AuthService();

final GoRouter router = GoRouter(
  initialLocation: '/',

  redirect: (BuildContext context, GoRouterState state) async { // ◀️ async 추가
    final bool loggedIn = await authService.isLoggedIn;
    final String location = state.uri.toString();

    // 로그인이 필요한 경로 목록
    final List<String> protectedRoutes = <String>[
      '/wish',
      '/mypage',
      '/orderlist',
      '/wish/cart'
    ];

    if (!loggedIn && protectedRoutes.any((String route) => location.startsWith(route))) {
      return '/auth/login';
    }

    return null;
  },

  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MainPage(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => const HomePage(),
        ),
        GoRoute(
          path: '/category',
          builder: (BuildContext context, GoRouterState state) => const CategoryPage(),
        ),
        GoRoute(
          path: '/wish',
          builder: (BuildContext context, GoRouterState state) => const WishPage(),
        ),
        GoRoute(
          path: '/mypage',
          builder: (BuildContext context, GoRouterState state) => const MyPage(),
        ),
        GoRoute(
          path: '/mypage/seller',
          builder: (BuildContext context, GoRouterState state) => SellerMyPage(),
        ),
        GoRoute(
          path: '/orderlist',
          builder: (BuildContext context, GoRouterState state) => const OrderListPage(),
        ),
        GoRoute(
          path: '/orderdetail/:orderId',
          builder: (BuildContext context, GoRouterState state) {
            final String orderId = state.pathParameters['orderId'] ?? "";
            return OrderDetailPage(orderId);
          },
        ),
        // GoRoute(
        //   path: '/mypage/edit-seller',
        //   builder: (context, state) => const EditProfileSellerPage(),
        // ),
        GoRoute(
            path: '/mypage/edit-buyer/:nickName/:profileUrl',
            builder: (BuildContext context, GoRouterState state) {
              final String nickName = state.pathParameters['nickName'] ?? '';
              final String profileUrl = state.pathParameters['profileUrl'] ?? '';
              return EditProfilePage(nickName: nickName, profileUrl: profileUrl);
            }),
        GoRoute(
          path: '/productslist/:categoryId',
          builder: (BuildContext context, GoRouterState state) {
            final String categoryId = state.pathParameters['categoryId'] ?? "";
            return ProductsListPage(categoryId: categoryId);
          },
        ),
        GoRoute(
          path: '/productdetail/:productId',
          builder: (BuildContext context, GoRouterState state) {
            final String productId = state.pathParameters['productId'] ?? "";
            return ProductsDetailPage(productId);
          },
        ),
        GoRoute(
          path: '/wish/cart',
          builder: (BuildContext context, GoRouterState state) => const CartPage(),
        ),
        GoRoute(
          path: '/mypage/password/:userId',
          builder: (BuildContext context, GoRouterState state) {
            final String userId = state.pathParameters['userId'] ?? "";
            return PasswordEditPage(userId: userId);
          },
        ),
        GoRoute(
          path: '/branddetail/:brandId',
          builder: (BuildContext context, GoRouterState state) {
            final String brandId = state.pathParameters['brandId'] ?? "";
            return BrandDetailPage(brandId);
          },
        ),
        GoRoute(
          path: '/funding/register',
          builder: (BuildContext context, GoRouterState state) => const FundingRegisterPage(),
        ),
        GoRoute(
          path: '/mypage/register',
          builder: (BuildContext context, GoRouterState state) => const ProductRegisterPage(),
        ),
        GoRoute(
          path: '/brand/editproduct',
          builder: (BuildContext context, GoRouterState state) => const BrandProductEditPage(),
        ),
        GoRoute(
          path: '/brand/edit',
          builder: (BuildContext context, GoRouterState state) => const BrandEditPage(),
        ),
        GoRoute(
          path: '/funding/edit/:fundingId',
          builder: (BuildContext context, GoRouterState state) {
            final String fundingId = state.pathParameters['fundingId'] ?? "";
            return FundingEditPage(fundingId: fundingId);
          },
        ),
        GoRoute(
          path: '/productedit/:productId',
          builder: (BuildContext context, GoRouterState state) {
            final String productId = state.pathParameters['productId'] ?? "";
            return ProductEditPage(productId: productId);
          }
        )
      ],
    ),

    GoRoute(
      path: '/auth/login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      path: '/auth/signup',
      builder: (BuildContext context, GoRouterState state) => const UserRoleSelectionPage(),
    ),
    GoRoute(
      path: '/auth/signup/common',
      builder: (BuildContext context, GoRouterState state) {
        final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
        return CommonSignupPage(
          store: extra?['store'],
        );
      },
    ),
    GoRoute(
      path: '/auth/signup/seller',
      builder: (BuildContext context, GoRouterState state) => SellerSignupPage(),
    ),
    GoRoute(
      path: '/auth/signup/completed',
      builder: (BuildContext context, GoRouterState state) => CompletedSignupPage(),
    ),
  ],
);
