import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:on_woori/core/styles/default_image.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

class ProductsGridItem extends StatefulWidget {
  final ProductItem item;

  const ProductsGridItem(this.item, {super.key});

  @override
  State<StatefulWidget> createState() => ProductsGridItemState();
}

class ProductsGridItemState extends State<ProductsGridItem> {
  final apiClient = ProductsApiClient();
  final storage = const FlutterSecureStorage();

  late int price;
  late int discount;
  late String productName;
  late String brandName;
  late String imageUrl;
  late bool isFavorite;

  static const String defaultProductThumbnail = DefaultImage.productThumbnail;

  @override
  void initState() {
    super.initState();

    price = widget.item.price;
    discount = int.tryParse(widget.item.discount ?? '') ?? 0;
    productName = widget.item.name;
    brandName = widget.item.store?.name ?? "브랜드";
    imageUrl = widget.item.thumbnailImage?.url ?? defaultProductThumbnail;
    isFavorite = widget.item.isFavorite ?? false;
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _toggleFavorite() async {
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    if (accessToken == null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('로그인 필요'),
          content: const Text('로그인이 필요한 기능입니다. 로그인 페이지로 이동하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.push('/auth/login');
              },
              child: const Text('로그인'),
            ),
          ],
        ),
      );
      return;
    }

    final originalState = isFavorite;
    setState(() {
      isFavorite = !isFavorite;
    });

    try {
      final response = await apiClient.toggleFavorite(
        productId: widget.item.id,
      );

      if (!response.success) {
        setState(() {
          isFavorite = originalState;
        });
      }
      _showSnackBar(response.message.message);
    } catch (e) {
      setState(() {
        isFavorite = originalState;
      });
      _showSnackBar('오류가 발생했습니다. 다시 시도해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final discountedPrice = price * (1 - discount / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                context.push('/productdetail/${widget.item.id}');
              },
              child: SizedBox(
                width: 170,
                child: AspectRatio(
                  aspectRatio: 0.8,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        defaultProductThumbnail,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: _toggleFavorite,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Flexible(
          child: GestureDetector(
            onTap: () {
              context.push('/productdetail/${widget.item.id}');
            },
            behavior: HitTestBehavior.translucent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (discount > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$discount%',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '${NumberFormat('#,###').format(discountedPrice)}원',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${NumberFormat('#,###').format(price)}원',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff7D7D7D),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    '${NumberFormat('#,###').format(price)}원',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  brandName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff7D7D7D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff7D7D7D),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

