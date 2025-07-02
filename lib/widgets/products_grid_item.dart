import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

class ProductsGridItem extends StatefulWidget {
  int price;
  String productName;
  String brandName;
  String imageUrl;
  bool isFavorite;

  ProductsGridItem(
    this.productName,
    this.brandName,
    this.imageUrl,
    this.isFavorite, {
    super.key,
    this.price = 0,
  });

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
    price = widget.price;
    productName = widget.productName;
    brandName = widget.brandName;
    isFavorite = widget.isFavorite;
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 170,
              height: 215,
              child: Image(image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                child: Icon(icon),
                onTap: () {
                  setState(() {
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
    );
  }
}
