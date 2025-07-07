import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:on_woori/core/styles/app_colors.dart';

class OrderListItem extends StatelessWidget {
  final String orderNumber;
  final String orderDate;
  final int totalAmount;
  final String status;
  final List<String> products;

  const OrderListItem({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,##0', 'en_US');
    final Color statusColor = AppColors.grey;

    return InkWell(
      onTap: () {
        context.push('/orderdetail');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '주문번호 : $orderNumber',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderDate,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '총 ${currencyFormat.format(totalAmount)}원',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '현재상태: $status',
                  style: TextStyle(
                    fontSize: 13,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: products.map((product) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    product,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF555555)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}