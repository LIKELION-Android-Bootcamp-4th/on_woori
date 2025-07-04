import 'package:flutter/material.dart';
import 'package:on_woori/widgets/order_list_item.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  final List<Map<String, dynamic>> _dummyOrders = const [
    {
      "orderNumber": "3847892347832",
      "orderDate": "2025.06.27",
      "totalAmount": 293000,
      "status": "주문완료",
      "products": [
        "배색 한복 원피스 (옵션 : 남색) 1개",
        "플라워 한복 악세사리 (옵션 : 1) 2개",
      ],
    },
    {
      "orderNumber": "2344432553244",
      "orderDate": "2025.06.26",
      "totalAmount": 293000,
      "status": "배송준비중",
      "products": [
        "배색 한복 원피스 (옵션 : 남색) 1개",
        "플라워 한복 악세사리 (옵션 : 1) 2개",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '나의 주문목록',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '총 주문 내역 ${_dummyOrders.length}개',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          // 주문 목록
          Expanded(
            child: ListView.builder(
              itemCount: _dummyOrders.length,
              itemBuilder: (context, index) {
                final order = _dummyOrders[index];
                return OrderListItem(
                  orderNumber: order['orderNumber'],
                  orderDate: order['orderDate'],
                  totalAmount: order['totalAmount'],
                  status: order['status'],
                  products: List<String>.from(order['products']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}