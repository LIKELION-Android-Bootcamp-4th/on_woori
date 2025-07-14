import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/core/styles/default_image.dart';
import 'package:on_woori/data/client/orders_api_client.dart';
import 'package:on_woori/data/entity/response/orders/order_detail_response.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("주문상세조회", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: FutureBuilder<OrderDetailResponse>(
        future: _orderDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("오류가 발생했습니다: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text("주문 정보를 찾을 수 없습니다."));
          }

          final order = snapshot.data!.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
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
                Text("주문 상품", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
                const SizedBox(height: 15),
                ListView.separated(
                  itemCount: order.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final product = order.items[index];
                    return OrderProductListItem(
                      imageUrl: product.thumbnailImageUrl ?? DefaultImage.productThumbnail,
                      productName: product.productName,
                      options: product.optionsText,
                      quantity: product.quantity,
                      price: product.totalPrice,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.black, height: 30, indent: 24, endIndent: 24),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black),
                const Text("결제 정보", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
                const SizedBox(height: 15),
                PriceInfoBox(
                  price: order.subtotalAmount,
                  shippingFee: order.shippingCost,
                  totalPrice: order.totalAmount,
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.black),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 24),
                //   child: Text("배송지 정보", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
                // ),
                // const SizedBox(height: 15),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 24),
                //   child: ShippingInfoBox(
                //     recipientName: order.shippingInfo.recipient,
                //     recipientPhone: order.shippingInfo.phone,
                //     zipCode: order.shippingInfo.zipCode,
                //     address1: order.shippingInfo.address,
                //     address2: "",
                //   ),
                // ),
                // const SizedBox(height: 10),
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
    final formattedDate = DateFormat('yyyy.MM.dd').format(orderDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "주문번호 $orderNumber",
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
              'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
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
                "$options | $quantity개",
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "$price원",
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
              const Text(
                "총 상품 금액",
                style: TextStyle(color: AppColors.grey, fontSize: 18),
              ),
              Text(
                "$price원",
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
              const Text(
                "총 배송비",
                style: TextStyle(color: AppColors.grey, fontSize: 18),
              ),
              Text(
                "$shippingFee원",
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
              const Text(
                "결제 금액",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$totalPrice원",
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

// class ShippingInfoBox extends StatelessWidget {
//   final String recipientName;
//   final String recipientPhone;
//   final String zipCode;
//   final String address1;
//   final String address2;
//
//   const ShippingInfoBox({
//     required this.recipientName,
//     required this.recipientPhone,
//     required this.zipCode,
//     required this.address1,
//     required this.address2,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: AppColors.categorySizeButtonUnSelected,
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("수령인", style: TextStyle(color: AppColors.grey, fontSize: 16)),
//               Text(recipientName, style: const TextStyle(color: Colors.black, fontSize: 16)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("핸드폰", style: TextStyle(color: AppColors.grey, fontSize: 16)),
//               Text(recipientPhone, style: const TextStyle(color: Colors.black, fontSize: 16)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Divider(color: Color(0xFFC9C9C9)),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("주소", style: TextStyle(color: AppColors.grey, fontSize: 16)),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text("($zipCode)", style: const TextStyle(color: Colors.black, fontSize: 16)),
//                     const SizedBox(height: 4),
//                     Text(address1, style: const TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.right),
//                     if (address2.isNotEmpty) ...[
//                       const SizedBox(height: 4),
//                       Text(address2, style: const TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.right),
//                     ]
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }