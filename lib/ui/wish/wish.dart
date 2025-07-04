import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/client/wishes_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/data/entity/response/mypage/wish_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/category_horizontal_scroll.dart';
import 'package:on_woori/widgets/list_toolbar.dart';
import 'package:on_woori/widgets/products_double_grid.dart';

class WishPage extends StatefulWidget {
  const WishPage({super.key});

  @override
  State<WishPage> createState() => WishPageState();
}

class WishPageState extends State<WishPage> {
  late Future<WishResponse> _apiDataFuture;

  @override
  void initState() {
    super.initState();
    _apiDataFuture = _initializeData();
  }

  Future<WishResponse> _initializeData() async {
    final response = await WishesApiClient().getWishList();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.bottomNavigationBarWish,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/wish/cart');
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: FutureBuilder<WishResponse>(
        future: _apiDataFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('위시리스트에 추가된 상품이 없습니다.'));
          }

          // API 응답(WishlistItem)을 위젯이 필요로 하는 데이터(ProductItem)로 변환합니다.
          // 값이 달라서 일단 어쩔 수 없이 채울 수 없는 정보는 빈 칸으로 임시 적용합니다.
          final List<WishlistItem> wishListItems = snapshot.data!.data.items;
          final List<ProductItem> productList = wishListItems.map((wishItem) {
            final product = wishItem.productId;
            final store = wishItem.store;

            return ProductItem(
              id: product.id,
              name: product.name,
              price: product.price,
              stock: product.stockQuantity,
              images: ProductImages(main: product.imageUrl),
              discount: product.discountRate,
              store: StoreData(
                name: store.name,
                owner: '',
                companyId: '',
              ),
              isFavorite: true,
              stockType: 'normal',
              status: 'approved',
            );
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CategoryHorizontalScroll(),
              ListToolbar(productList.length),
              Expanded(
                child: productList.isEmpty
                    ? const Center(child: Text('위시리스트에 추가된 상품이 없습니다.'))
                    : ProductsDoubleGrid(
                  productList,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
