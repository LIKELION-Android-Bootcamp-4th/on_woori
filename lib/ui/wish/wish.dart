import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/client/wishes_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart'
as P;
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.navBarWish,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/wish/cart');
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/auth/login');
              debugPrint('오류 발생: ${snapshot.error}');
            });
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData ||
              (snapshot.data!.data?.items?.isEmpty ?? true)) {
            return Center(child: Text(l10n.wishlistEmpty));
          }

          final wishListItems = snapshot.data!.data!.items!;

          final List<P.ProductItem> productList = wishListItems
              .map((wishItem) {
            final productEntity = wishItem.entity;
            if (productEntity == null) {
              return null;
            }

            P.ThumbnailImage? thumbnail;
            final detailImages = productEntity.images?.detail;
            if (detailImages != null && detailImages.isNotEmpty) {
              thumbnail = P.ThumbnailImage(
                id: productEntity.id,
                url: productEntity.thumbnailImage?.url ?? l10n.dummyImage,
              );
            }

            return P.ProductItem(
              id: productEntity.id,
              name: productEntity.name,
              description: "",
              price: productEntity.price,
              isFavorite: true,
              stock: null,
              stockType: null,
              discount: null,
              status: null,
              store: wishItem.store != null
                  ? P.StoreData(name: wishItem.store!.name)
                  : null,
              thumbnailImage: thumbnail,
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
                const SizedBox(height: 30,),
                Expanded(
                  child: productList.isEmpty
                      ? Center(child: Text(l10n.wishlistNoItemsToDisplay))
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