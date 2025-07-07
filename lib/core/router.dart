import 'package:go_router/go_router.dart';

import 'package:on_woori/main.dart';
import 'package:on_woori/ui/brand/brand_product_edit.dart';
import 'package:on_woori/ui/brand/brand_detail.dart';
import 'package:on_woori/ui/auth/signup/common_signup_page.dart';
import 'package:on_woori/ui/auth/signup/completed_signup_page.dart';
import 'package:on_woori/ui/auth/signup/seller_signup_page.dart';
import 'package:on_woori/ui/auth/signup/user_role_selection_page.dart';
import 'package:on_woori/ui/cart/cart.dart';
import 'package:on_woori/ui/category/category.dart';
import 'package:on_woori/ui/home/home.dart';
import 'package:on_woori/ui/mypage/mypage.dart';
import 'package:on_woori/ui/order/order_detail_page.dart';
import 'package:on_woori/ui/order/order_list.dart';
import 'package:on_woori/ui/mypage_seller/mypage_seller.dart';
import 'package:on_woori/ui/products/products_detail.dart';
import 'package:on_woori/ui/products/products_list.dart';
import 'package:on_woori/ui/wish/wish.dart';
import 'package:on_woori/ui/mypage/editprofile/editprofile.dart';
import 'package:on_woori/ui/auth/login/login_page.dart';
import 'package:on_woori/ui/mypage/change-password.dart';
import 'package:on_woori/ui/mypage_seller/add_funding.dart';
import 'package:on_woori/ui/mypage_seller/add_product.dart';
import 'package:on_woori/ui/mypage_seller/edit_brand.dart';
import 'package:on_woori/ui/mypage_seller/editprofile/edit_profile_seller.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
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
          builder: (context, state) => const SellerMyPage(),
        ),
        GoRoute(
          path: '/orderlist',
          builder: (context, state) => const OrderListPage(),
        ),
        GoRoute(
          path: '/orderlist',
          builder: (context, state) {
            return const OrderListPage();
          },
        ),
        GoRoute(
          path: '/orderdetail',
          builder: (context, state) => const OrderDetailPage(),
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
          builder: (context, state) => CommonSignupPage(),
        ),
        GoRoute(
          path: '/auth/signup/seller',
          builder: (context, state) => SellerSignupPage(),
        ),
        GoRoute(
          path: '/auth/signup/completed',
          builder: (context, state) => CompletedSignupPage(),
        ),
        GoRoute(
          path: '/mypage/edit',
          builder: (context, state) => const EditProfilePage(),
        ),
        GoRoute(
          path: '/mypage/edit-seller',
          builder: (context, state) => const EditProfileSellerPage(),
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
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          path: '/mypage/password',
          builder: (context, state) => const PasswordEditPage(),
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
      ],
    ),
  ],
);
