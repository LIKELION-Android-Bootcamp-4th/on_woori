import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
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
        title: Text(l10n.productDetailTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
        actions: [
          IconButton(onPressed: (){
            context.push('/wish/cart');
          }, icon: const Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: Row(
        children: [
          const SizedBox(width: 24),
          Expanded(child: ProductsDetailScreen(productId)),
          const SizedBox(width: 24),
        ],
      ),
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
  final apiClient = ProductsApiClient();
  late Future<ProductsDetailResponse> _productsFuture;

  int quantity = 1;
  String? selectedColor;
  String? selectedSize;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _productsFuture = apiClient.productDetail(widget.id);
  }

  void _toggleFavorite() {
    // TODO: 찜하기 API 호출 로직 추가
    setState(() {
      isFavorite = !isFavorite;
    });
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

        isFavorite = product.isFavorite;

        // 옵션 응답이 다 달라서 더미로 대체
        // final sizeOptions = product.options?.size ?? [];
        // final colorOptions = product.options?.color ?? [];

        // 더미 데이터로 옵션 목록을 설정합니다.
        final List<String> sizeOptions = ['S', 'M', 'L', 'XL'];
        final List<String> colorOptions = ['블랙', '화이트', '네이비', '카키'];

        final totalPrice = product.price * quantity;
        const placeholderImage = 'https://via.placeholder.com/400';

        return ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                child: Image.network(
                  product.images?.main ?? placeholderImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.network(placeholderImage, fit: BoxFit.cover),
                ),
              ),
            ),
            const Divider(color: Colors.black, thickness: 1, height: 1),
            const SizedBox(height: 10),

            // --- 상품명, 가격, 찜하기 버튼 ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ProductsNameSection.fromProduct(product)),
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 30),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
            const Divider(color: Colors.black),

            // --- 브랜드 정보 ---
            Row(
              children: [
                const CircleAvatar(backgroundColor: AppColors.primary, radius: 16),
                const SizedBox(width: 10),
                Text(product.store?.name ?? "브랜드 정보 없음")
              ],
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 20),

            // --- 상품 상세 이미지 ---
            ProductsDetailImageSection(product.images?.detail ?? []),
            const SizedBox(height: 20),
            const Divider(color: Colors.black),

            // --- 옵션 선택 ---
            // [핵심] 옵션 목록이 있을 때만 드롭다운 UI를 보여줍니다.
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

            // --- 하단 수량 및 가격 정보 ---
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
                        Text(product.name, style: const TextStyle(fontSize: 16)),
                        if (selectedSize != null) Text('사이즈: $selectedSize', style: const TextStyle(fontSize: 13, color: AppColors.grey)),
                        if (selectedColor != null) Text('색상: $selectedColor', style: const TextStyle(fontSize: 13, color: AppColors.grey)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("$totalPrice원", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() { if (quantity > 1) quantity--; })),
                          Text("$quantity", style: const TextStyle(fontSize: 20)),
                          IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => quantity++)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () { /* TODO: 장바구니 추가 로직 */ },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.primary),
                child: Text(l10n.cart, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () { /* TODO: 주문 생성 로직 */ },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.primary),
                child: Text(l10n.order, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
              ),
            ),
            const SizedBox(height: 20)
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
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
          Text("$originalPrice원", style: const TextStyle(fontSize: 10, decoration: TextDecoration.lineThrough, color: AppColors.grey)),
          const SizedBox(height: 2),
          Row(
            children: [
              Text("$discountRate%", style: const TextStyle(fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold)),
              const SizedBox(width: 5),
              Text("$discountedPrice원", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ] else ...[
          Text("$originalPrice원", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
    const placeholderImage = 'https://via.placeholder.com/400';
    if (detailImageUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      children: detailImageUrls.map((url) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Image.network(
          url,
          errorBuilder: (context, error, stackTrace) => Image.network(placeholderImage),
        ),
      )).toList(),
    );
  }
}