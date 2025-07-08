import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/client/wishes_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart' as P;
import 'package:on_woori/data/entity/response/mypage/wish_response.dart'; // ⭐️ 새로운 응답 엔티티 import
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/category_horizontal_scroll.dart';
import 'package:on_woori/widgets/list_toolbar.dart';
import 'package:on_woori/widgets/products_double_grid.dart';

class WishPage extends StatefulWidget {
  const WishPage({super.key});

  @override
  State<WishPage> createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  late Future<WishResponse> _apiDataFuture;

  @override
  void initState() {
    super.initState();
    _apiDataFuture = _initializeData();
  }

  Future<WishResponse> _initializeData() async {
    return await WishesApiClient().getWishList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.bottomNavigationBarWish,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/wish/cart');
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          )
        ],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<WishResponse>(
        future: _apiDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("오류가 발생했습니다: ${snapshot.error}"));
          }
          if (!snapshot.hasData || (snapshot.data!.data?.items?.isEmpty ?? true)) {
            return const Center(child: Text('위시리스트에 추가된 상품이 없습니다.'));
          }

          final wishListItems = snapshot.data!.data!.items!;

          final List<P.ProductItem> productList = wishListItems.map((wishItem) {
            final productEntity = wishItem.entity;
            if (productEntity == null) {
              return null;
            }

            P.ThumbnailImage? thumbnail;
            final detailImages = productEntity.images?.detail;
            if (detailImages != null && detailImages.isNotEmpty) {
              thumbnail = P.ThumbnailImage(
                id: productEntity.id,
                url: detailImages.first,
              );
            }

            return P.ProductItem(
              id: productEntity.id,
              name: productEntity.name,
              price: productEntity.price,
              isFavorite: true, // 위시리스트의 모든 상품은 isFavorite가 true
              // WishResponse에 없는 데이터는 null 또는 기본값 처리
              stock: null,
              stockType: null,
              discount: null,
              status: null,
              store: wishItem.store != null ? P.StoreData(name: wishItem.store!.name) : null,
              thumbnailImage: thumbnail, // 추출한 썸네일 할당
              images: productEntity.images,
            );
          })
              .whereType<P.ProductItem>()
              .toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CategoryHorizontalScroll(),
                ListToolbar(productList.length),
                Expanded(
                  child: productList.isEmpty
                      ? const Center(child: Text('표시할 상품이 없습니다.'))
                      : ProductsDoubleGrid(productList),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}