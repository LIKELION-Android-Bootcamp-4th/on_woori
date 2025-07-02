import 'package:flutter/material.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class ProductsDoubleGrid extends StatelessWidget {
  //TODO: API 명세와 결정된 상품 엔티티에 따른 DTO 생성 및 사용
  //DTO 생성 전까지는 하드코딩함

  int itemCount;
  ProductsDoubleGrid(this.itemCount);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 15),
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
            price: 0,
          );
        }
    );
  }

}