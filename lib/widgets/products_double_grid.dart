import 'package:flutter/material.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class ProductsDoubleGrid extends StatelessWidget {
  List<ProductItem> itemList;

  ProductsDoubleGrid(this.itemList);

  @override
  Widget build(BuildContext context) {
    if (itemList.isEmpty) {
      return Container();
    }
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1 / 1.7,
      ),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return ProductsGridItem(itemList[index]);
      },
    );
  }
}

class ProductsNonScrollableGrid extends StatelessWidget {
  List<ProductItem> itemList;

  ProductsNonScrollableGrid(this.itemList);

  @override
  Widget build(BuildContext context) {
    if (itemList.isEmpty) {
      return Container();
    }
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 15),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1 / 1.7,
      ),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return ProductsGridItem(itemList[index]);
      },
    );
  }
}
