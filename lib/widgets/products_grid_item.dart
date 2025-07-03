import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

class ProductsGridItem extends StatefulWidget {
  ProductItem item;
  ProductsGridItem(this.item);

  @override
  State<StatefulWidget> createState() => ProductsGridItemState();
}

class ProductsGridItemState extends State<ProductsGridItem> {
  late int price;
  late String productName;
  late String brandName;
  late String imageUrl;
  late bool isFavorite;
  var icon = Icons.circle;

  @override
  void initState() {
    super.initState();
    price = widget.item.price;
    productName = widget.item.name;
    brandName = widget.item.store?.name ?? "브랜드";
    isFavorite = widget.item.isFavorite;
    imageUrl = widget.item.images?.main ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.push('/productdetail/${widget.item.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 0.8,
                  child: SizedBox(
                    width: 170,
                    child: Image(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: GestureDetector(
                    child: Icon(icon),
                    onTap: () {
                      setState(() { //TODO: favorite 등록
                        isFavorite = !isFavorite;
                        if (isFavorite) {
                          icon = Icons.circle_outlined;
                        } else {
                          icon = Icons.circle;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Text(
              "$price",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              brandName,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff7D7D7D),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              productName,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff7D7D7D),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
    );
  }
}
