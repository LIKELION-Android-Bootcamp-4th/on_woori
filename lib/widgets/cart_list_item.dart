import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

class CartListItem extends StatefulWidget {
  String productName;
  String option;
  int productCount;
  int price;
  String imageUrl;

  CartListItem({
    required this.productName,
    required this.option,
    required this.productCount,
    required this.price,
    required this.imageUrl,
    super.key,
  });

  @override
  State createState() {
    return CartListItemState();
  }
}

class CartListItemState extends State<CartListItem> {
  late String productName;
  late String option;
  late int productCount;
  late int price;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    productName = widget.productName;
    option = widget.option;
    productCount = widget.productCount;
    price = widget.price;
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 상품명 + 삭제 아이콘
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              child: Icon(Icons.delete_outlined, color: Color(0xFF7D7D7D)),
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: 10),

        // 상품 이미지 + 옵션/수량/가격
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            // 상품 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 10),

            // 옵션 + 수량 컨트롤 + 가격
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "옵션",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 270,
                    child: Row(
                      children: [
                        // 수량 컨트롤
                        Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Icon(Icons.remove, size: 20),
                                onTap: () {
                                  if (productCount > 1) {
                                    setState(() {
                                      productCount--;
                                    });
                                  }
                                },
                              ),
                              Text("$productCount"),
                              InkWell(
                                child: Icon(Icons.add, size: 20),
                                onTap: () {
                                  setState(() {
                                    productCount++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // 가격
                        Text(
                          "${price * productCount}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
