import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/main.dart'; // MainPage가 있는 파일 경로

// --- 실제 앱에 맞게 수정해야 할 부분 ---
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
import 'package:on_woori/ui/mypage_seller/editprofile/edit_profile_seller.dart';
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
  final _storage = const FlutterSecureStorage();

  Future<bool> get isLoggedIn async {
    final token = await _storage.read(key: 'ACCESS_TOKEN');
    return token != null;
  }
}

final authService = AuthService();


final GoRouter router = GoRouter(
  initialLocation: '/',

  redirect: (BuildContext context, GoRouterState state) async { // ◀️ async 추가
    final bool loggedIn = await authService.isLoggedIn;
    final String location = state.uri.toString();

    // 로그인이 필요한 경로 목록
    final protectedRoutes = [
      '/wish',
      '/mypage',
      '/orderlist',
      '/wish/cart'
    ];

    if (!loggedIn && protectedRoutes.any((route) => location.startsWith(route))) {
      return '/auth/login';
    }

    return null;
  },

  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/category',
          builder: (context, state) => const CategoryPage(),
        ),
        GoRoute(
          path: '/wish',
          builder: (context, state) => const WishPage(),
        ),
        GoRoute(
          path: '/mypage',
          builder: (context, state) => const MyPage(),
        ),
        GoRoute(
          path: '/mypage/seller',
          builder: (context, state) => SellerMyPage(),
        ),
        GoRoute(
          path: '/orderlist',
          builder: (context, state) => const OrderListPage(),
        ),
        GoRoute(
          path: '/orderdetail/:orderId',
          builder: (context, state) {
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
            builder: (context, state) {
              final String nickName = state.pathParameters['nickName'] ?? '';
              final String profileUrl = state.pathParameters['profileUrl'] ?? '';
              return EditProfilePage(nickName: nickName, profileUrl: profileUrl);
            }),
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
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          path: '/mypage/password/:userId',
          builder: (context, state) {
            final String userId = state.pathParameters['userId'] ?? "";
            return PasswordEditPage(userId: userId);
          },
        ),
        GoRoute(
          path: '/branddetail/:brandId',
          builder: (context, state) {
            final String brandId = state.pathParameters['brandId'] ?? "";
            return BrandDetailPage(brandId);
          },
        ),
        GoRoute(
          path: '/funding/register',
          builder: (context, state) => const FundingRegisterPage(),
        ),
        GoRoute(
          path: '/mypage/register',
          builder: (context, state) => const ProductRegisterPage(),
        ),
        GoRoute(
          path: '/brand/editproduct',
          builder: (context, state) => BrandProductEditPage(),
        ),
        GoRoute(
          path: '/brand/edit',
          builder: (context, state) => const BrandEditPage(),
        ),
        GoRoute(
          path: '/funding/edit/:fundingId',
          builder: (context, state) {
            final String fundingId = state.pathParameters['fundingId'] ?? "";
            return FundingEditPage(fundingId: fundingId);
          },
        ),
        GoRoute(
          path: '/productedit/:productId',
          builder: (context, state) {
            final String productId = state.pathParameters['productId'] ?? "";
            return ProductEditPage(productId: productId);
          }
        )
      ],
    ),

    GoRoute(
      path: '/auth/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/auth/signup',
      builder: (context, state) => UserRoleSelectionPage(),
    ),
    GoRoute(
      path: '/auth/signup/common',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return CommonSignupPage(
          store: extra?['store'],
        );
      },
    ),
    GoRoute(
      path: '/auth/signup/seller',
      builder: (context, state) => SellerSignupPage(),
    ),
    GoRoute(
      path: '/auth/signup/completed',
      builder: (context, state) => CompletedSignupPage(),
    ),
  ],
);
