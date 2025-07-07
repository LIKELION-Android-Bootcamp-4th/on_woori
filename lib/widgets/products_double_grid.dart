import 'package:flutter/material.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class ProductsDoubleGrid extends StatelessWidget {
  final List<dynamic> rawItemList;
  ProductsDoubleGrid(this.rawItemList);

  // 🩷 서버에서 받은 raw 리스트를 안전하게 ProductItem으로 변환
  List<ProductItem> _parseItems() {
    return rawItemList
        .where((e) => e is Map<String, dynamic>)
        .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final itemList = _parseItems();

    if (itemList.isEmpty) {
      return Center(child: Text('상품이 없습니다.'));
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
  final List<dynamic> rawItemList;
  ProductsNonScrollableGrid(this.rawItemList);

  // 🩷 서버에서 받은 raw 리스트를 안전하게 ProductItem으로 변환
  List<ProductItem> _parseItems() {
    return rawItemList
        .where((e) => e is Map<String, dynamic>)
        .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final itemList = _parseItems();

    if (itemList.isEmpty) {
      return Center(child: Text('상품이 없습니다.'));
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
