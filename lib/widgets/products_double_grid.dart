import 'package:flutter/material.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class ProductsDoubleGrid extends StatelessWidget {
  final List<ProductItem> itemList;

  const ProductsDoubleGrid(this.itemList, {super.key});

  @override
  Widget build(BuildContext context) {
    if (itemList.isEmpty) {
      return Container();
    }
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        // 아이템의 높이를 늘리기 위해 childAspectRatio 값을 조정합니다. (1.7 -> 1.8)
        // 이 값은 폰트 크기나 패딩에 따라 미세 조정이 필요할 수 있습니다.
        childAspectRatio: 1 / 1.8,
      ),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return ProductsGridItem(itemList[index]);
      },
    );
  }
}

class ProductsNonScrollableGrid extends StatelessWidget {
  final List<ProductItem> itemList;

  const ProductsNonScrollableGrid(this.itemList, {super.key});

  @override
  Widget build(BuildContext context) {
    if (itemList.isEmpty) {
      return Container();
    }
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        // 여기도 동일하게 childAspectRatio 값을 조정합니다. (1.7 -> 1.8)
        childAspectRatio: 1 / 1.8,
      ),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return ProductsGridItem(itemList[index]);
      },
    );
  }
}
