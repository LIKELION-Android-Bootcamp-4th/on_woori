import 'package:flutter/material.dart';
import 'package:on_woori/data/client/wishes_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart' as P;
import 'package:on_woori/data/entity/response/mypage/wish_response.dart';
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
      appBar: AppBar( /* ... 이전과 동일 ... */ ),
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

          final List<P.ProductItem> productList = wishListItems
              .map((wishItem) {
            final product = wishItem.product;
            final store = wishItem.store;
            if (product == null) {
              return null;
            }

            final thumbnail = product.thumbnailImage != null
                ? P.ThumbnailImage(
              id: product.thumbnailImage!.id,
              url: product.thumbnailImage!.url,
            )
                : null;

            final images = null;

            return P.ProductItem(
              id: product.id,
              name: product.name,
              price: product.price,
              isFavorite: true,
              stock: product.stock,
              stockType: product.stockType,
              discount: product.discount,
              status: product.status,
              store: store != null ? P.StoreData(name: store.name) : null,
              thumbnailImage: thumbnail,
              images: images,
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