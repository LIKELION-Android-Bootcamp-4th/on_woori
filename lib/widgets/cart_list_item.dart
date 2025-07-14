import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

class CartListItem extends StatefulWidget {
  final String productName;
  final String option;
  final int productCount;
  final int price;
  final String imageUrl;
  final VoidCallback? onDelete;

  const CartListItem({
    required this.productName,
    required this.option,
    required this.productCount,
    required this.price,
    required this.imageUrl,
    this.onDelete,
    super.key,
  });

  @override
  State<CartListItem> createState() {
    return CartListItemState();
  }
}

class CartListItemState extends State<CartListItem> {
  late int productCount;

  @override
  void initState() {
    super.initState();
    productCount = widget.productCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.productName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: widget.onDelete,
              child: const Icon(
                Icons.delete_outlined,
                color: Color(0xFF7D7D7D),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 옵션
                  Text(
                    widget.option,
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
                            border: Border.all(color: const Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: const Icon(Icons.remove, size: 20),
                                onTap: () {
                                  if (productCount > 1) {
                                    setState(() => productCount--);
                                    // TODO: 수량 변경 API 호출 로직 추가
                                  }
                                },
                              ),
                              Text("$productCount"),
                              InkWell(
                                child: const Icon(Icons.add, size: 20),
                                onTap: () {
                                  setState(() => productCount++);
                                  // TODO: 수량 변경 API 호출 로직 추가
                                },
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // 가격
                        Text(
                          "${widget.price * productCount}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
