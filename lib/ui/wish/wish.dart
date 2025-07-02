import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/category_horizontal_scroll.dart';
import 'package:on_woori/widgets/category_horizontal_scroll_item.dart';
import 'package:on_woori/widgets/list_toolbar.dart';
import 'package:on_woori/widgets/products_double_grid.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class WishPage extends StatelessWidget {
  const WishPage({super.key});

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
              context.push('/wish/cart');
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
                child: ProductsDoubleGrid(itemCount)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
