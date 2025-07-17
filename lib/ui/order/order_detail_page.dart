import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/core/styles/default_image.dart';
import 'package:on_woori/data/client/orders_api_client.dart';
import 'package:on_woori/data/entity/response/orders/order_detail_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;

  const OrderDetailPage(this.orderId, {super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<OrderDetailResponse> _orderDetailFuture;

  @override
  void initState() {
    super.initState();
    _orderDetailFuture = _fetchOrderDetail();
  }

  Future<OrderDetailResponse> _fetchOrderDetail() async {
    try {
      return await OrdersApiClient().getOrderDetail(orderId: widget.orderId);
    } catch (e, s) {
      debugPrint("주문 상세 정보 조회 API 오류: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.orderDetailPageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: FutureBuilder<OrderDetailResponse>(
        future: _orderDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(l10n.orderDetailPageError('${snapshot.error}')));
          }
          if (!snapshot.hasData || snapshot.data?.data == null) {
            return Center(child: Text(l10n.orderDetailPageNoData));
          }

          final order = snapshot.data!.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                OrderDetailHeader(
                  orderNumber: order.orderNumber,
                  orderDate: order.orderDate,
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black),
                Text(
                  l10n.orderDetailSectionProducts,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                ListView.separated(
                  itemCount: order.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final product = order.items[index];
                    return OrderProductListItem(
                      imageUrl: product.thumbnailImageUrl ??
                          DefaultImage.productThumbnail,
                      productName: product.productName,
                      options: product.optionsText,
                      quantity: product.quantity,
                      price: product.totalPrice,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    color: Colors.black,
                    height: 30,
                    indent: 24,
                    endIndent: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black),
                Text(
                  l10n.orderDetailSectionPayment,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                PriceInfoBox(
                  price: order.subtotalAmount,
                  shippingFee: order.shippingCost,
                  totalPrice: order.totalAmount,
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.black),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailHeader extends StatelessWidget {
  final String orderNumber;
  final DateTime orderDate;
  final String? userName;

  const OrderDetailHeader({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formattedDate = DateFormat('yyyy.MM.dd').format(orderDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.orderDetailHeaderNumber(orderNumber),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Text(
          formattedDate,
          style: const TextStyle(color: AppColors.grey, fontSize: 13),
        ),
      ],
    );
  }
}

class OrderProductListItem extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String options;
  final int quantity;
  final int price;

  const OrderProductListItem({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.options,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formatter = NumberFormat('#,###');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Image.network(
              l10n.dummyImage,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                l10n.orderDetailProductOptions(options, quantity),
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                l10n.currencyFormat(formatter.format(price)),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceInfoBox extends StatelessWidget {
  final int price;
  final int shippingFee;
  final int totalPrice;

  const PriceInfoBox({
    required this.price,
    required this.shippingFee,
    required this.totalPrice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formatter = NumberFormat('#,###');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.categorySizeButtonUnSelected,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.orderDetailTotalProductAmount,
                style: const TextStyle(color: AppColors.grey, fontSize: 18),
              ),
              Text(
                l10n.currencyFormat(formatter.format(price)),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.orderDetailShippingFee,
                style: const TextStyle(color: AppColors.grey, fontSize: 18),
              ),
              Text(
                l10n.currencyFormat(formatter.format(shippingFee)),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFFC9C9C9)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.orderDetailTotalPayment,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                l10n.currencyFormat(formatter.format(totalPrice)),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
