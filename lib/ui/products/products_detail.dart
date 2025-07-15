import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/core/styles/default_image.dart';
import 'package:on_woori/data/client/cart_api_client.dart';
import 'package:on_woori/data/entity/request/cart/cart_register_request.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_detail_response.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class ProductsDetailPage extends StatelessWidget {
  final String productId;

  const ProductsDetailPage(this.productId, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.productDetailTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/wish/cart');
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: ProductsDetailScreen(productId),
    );
  }
}

class ProductsDetailScreen extends StatefulWidget {
  final String id;

  const ProductsDetailScreen(this.id, {super.key});

  @override
  State<ProductsDetailScreen> createState() {
    return _ProductsDetailScreenState();
  }
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  final productsApiClient = ProductsApiClient();
  final cartApiClient = CartApiClient();

  late Future<ProductsDetailResponse> _productsFuture;

  int quantity = 1;
  String? selectedColor;
  String? selectedSize;

  late bool isLiked;

  @override
  void initState() {
    super.initState();
    _productsFuture = productsApiClient.productDetail(widget.id).then((
        response,
        ) {
      isLiked = response.data?.isFavorite ?? false;
      return response;
    });
  }

  Future<void> _toggleFavorite() async {
    final originalState = isLiked;
    setState(() {
      isLiked = !isLiked;
    });

    try {
      final response = await productsApiClient.toggleFavorite(
        productId: widget.id,
      );

      if (response.success) {
        setState(() {
          isLiked = response.message.result.isLiked;
        });
      } else {
        setState(() {
          isLiked = originalState;
        });
        _showSnackBar(response.message.message);
      }
    } catch (e) {
      setState(() {
        isLiked = originalState;
      });
      _showSnackBar('오류가 발생했습니다. 다시 시도해주세요.');
    }
  }

  Future<void> _addToCart(
      ProductItem product,
      List<String> sizeOptions,
      List<String> colorOptions,
      ) async {
    if (sizeOptions.isNotEmpty && selectedSize == null) {
      _showSnackBar('사이즈를 선택해주세요.');
      return;
    }
    if (colorOptions.isNotEmpty && selectedColor == null) {
      _showSnackBar('색상을 선택해주세요.');
      return;
    }

    final request = CartRegisterRequest(
      productId: product.id,
      quantity: quantity,
      unitPrice: product.price,
    );

    try {
      final response = await cartApiClient.addToCart(request: request);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar(
          '장바구니에 상품을 추가했습니다.',
          backgroundColor: Colors.green, // 성공 시 초록색 전달
        );
      } else {
        _showSnackBar('장바구니 추가에 실패했습니다: ${response.data}');
      }
    } catch (e) {
      _showSnackBar('오류가 발생했습니다: $e');
    }
  }

  void _showSnackBar(String message, {Color? backgroundColor}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return FutureBuilder<ProductsDetailResponse>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("오류 발생: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data?.data == null) {
          return const Center(child: Text("상품 정보를 찾을 수 없습니다."));
        }

        final product = snapshot.data!.data!;

        List<String> sizeOptions = [];
        List<String> colorOptions = [];
        if (product.options != null) {
          for (final optionGroup in product.options!) {
            if (optionGroup.name == '사이즈') {
              sizeOptions = optionGroup.items.map((item) => item.code).toList();
            } else if (optionGroup.name == '컬러') {
              colorOptions =
                  optionGroup.items.map((item) => item.code).toList();
            }
          }
        }

        final totalPrice = product.price * quantity;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  product.thumbnailImage?.url ?? DefaultImage.productThumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    DefaultImage.productThumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.black, thickness: 1, height: 1),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ProductsNameSection.fromProduct(product)),
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
            const Divider(color: Colors.black),
            ListTile(
              onTap: () {
                if (product.store?.id != null) {
                  context.push('/branddetail/${product.store!.id}');
                }
              },
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 16,
                child: ClipOval(
                  child: Image.network(
                    product.store?.thumbnailImageUrl ??
                        DefaultImage.brandThumbnail,
                    fit: BoxFit.cover,
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        DefaultImage.brandThumbnail,
                        fit: BoxFit.cover,
                        width: 32,
                        height: 32,
                      );
                    },
                  ),
                ),
              ),
              title: Text(
                product.store?.name ?? "브랜드 정보 없음",
                style: const TextStyle(fontSize: 16),
              ),
              dense: true,
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 20),
            ProductsDetailImageSection(product.images?.detail ?? []),
            const SizedBox(height: 20),
            const Divider(color: Colors.black),
            if (sizeOptions.isNotEmpty) ...[
              OptionDropdown(
                hint: "사이즈 선택",
                value: selectedSize,
                items: sizeOptions,
                onChanged: (value) => setState(() => selectedSize = value),
              ),
              const SizedBox(height: 5),
            ],
            if (colorOptions.isNotEmpty) ...[
              OptionDropdown(
                hint: "색상 선택",
                value: selectedColor,
                items: colorOptions,
                onChanged: (value) => setState(() => selectedColor = value),
              ),
              const SizedBox(height: 5),
            ],
            Container(
              color: AppColors.optionStateList,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (selectedSize != null)
                          Text(
                            '사이즈: $selectedSize',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                          ),
                        if (selectedColor != null)
                          Text(
                            '색상: $selectedColor',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${NumberFormat('#,###').format(totalPrice)}원",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => setState(() {
                              if (quantity > 1) quantity--;
                            }),
                          ),
                          Text(
                            "$quantity",
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => setState(() => quantity++),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () => _addToCart(product, sizeOptions, colorOptions),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  l10n.cart,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
class OptionDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const OptionDropdown({
    required this.hint,
    this.value,
    required this.items,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.optionStateList,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: value,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class ProductsNameSection extends StatelessWidget {
  final String category;
  final String productName;
  final int originalPrice;
  final int? discountRate;
  final bool hasDiscount;
  final int discountedPrice;

  const ProductsNameSection({
    super.key,
    required this.category,
    required this.productName,
    required this.originalPrice,
    this.discountRate,
    required this.hasDiscount,
    required this.discountedPrice,
  });

  factory ProductsNameSection.fromProduct(ProductItem product) {
    int? rate;
    bool hasDiscount = false;
    int finalPrice = product.price;

    if (product.discount != null && product.discount!.isNotEmpty) {
      try {
        final discountData = jsonDecode(product.discount!);
        rate = discountData['value'];
        if (rate != null && rate > 0) {
          hasDiscount = true;
          finalPrice = (product.price * (100 - rate) / 100).round();
        }
      } catch (e) {
        rate = null;
        hasDiscount = false;
      }
    }

    return ProductsNameSection(
      category: product.stockType ?? "카테고리",
      productName: product.name,
      originalPrice: product.price,
      discountRate: rate,
      hasDiscount: hasDiscount,
      discountedPrice: finalPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(fontSize: 10)),
        const SizedBox(height: 2),
        Text(productName, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 2),
        if (hasDiscount) ...[
          Text(
            "${NumberFormat('#.###').format(originalPrice)}원",
            style: const TextStyle(
              fontSize: 10,
              decoration: TextDecoration.lineThrough,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                "$discountRate%",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "$discountedPrice원",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ] else ...[
          Text(
            "$originalPrice원",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }
}

class ProductsDetailImageSection extends StatelessWidget {
  final List<String> detailImageUrls;

  const ProductsDetailImageSection(this.detailImageUrls, {super.key});

  @override
  Widget build(BuildContext context) {
    if (detailImageUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      children: detailImageUrls
          .map(
            (url) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Image.network(
                url,
                errorBuilder: (context, error, stackTrace) => SizedBox.shrink(),
              ),
            ),
          )
          .toList(),
    );
  }
}
