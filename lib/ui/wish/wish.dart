import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/client/wishes_api_client.dart';
import 'package:on_woori/data/entity/response/wishes/wish_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/category_horizontal_scroll.dart';
import 'package:on_woori/widgets/category_horizontal_scroll_item.dart';
import 'package:on_woori/widgets/list_toolbar.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class WishPage extends StatefulWidget {
  const WishPage({super.key});

  @override
  State<WishPage> createState() => WishPageState();
}

class WishPageState extends State<WishPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    int itemCount = 10;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.bottomNavigationBarWish,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/wish/cart');
            },
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CategoryHorizontalScroll(),
          ListToolbar(itemCount),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 360,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1 / 1.7,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return ProductsGridItem(
                      "상품명",
                      "브랜드명",
                      "https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg",
                      false,
                      price: 16800,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }
}
