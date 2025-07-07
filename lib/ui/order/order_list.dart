import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_woori/data/client/orders_api_client.dart';
import 'package:on_woori/data/entity/response/orders/orders_response.dart';

import 'package:on_woori/widgets/order_list_item.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late Future<OrdersResponse> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _initializeData();
  }

  Future<OrdersResponse> _initializeData() async {
    try {
      final response = await OrdersApiClient().getOrders();
      return response;
    } catch (e, s) {
      debugPrint("주문 목록 조회 오류: $e");
      print(s);
      rethrow;
    }
  }

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
      body: FutureBuilder<OrdersResponse>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("오류가 발생했습니다: ${snapshot.error}"));
          }
          // data나 orders가 null 또는 비어있는 경우를 모두 처리
          if (!snapshot.hasData || (snapshot.data!.data.orders.isEmpty)) {
            return const Center(child: Text("주문 내역이 없습니다."));
          }

          final ordersData = snapshot.data!.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Text(
                  '총 주문 내역 ${ordersData.orders.length}개',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (context, index) {
                    final order = ordersData.orders[index];

                    // 3. 상품 목록 문자열을 UI에서 직접 생성합니다.
                    final productSummaries = order.products
                        .map((p) => '${p.productName} ${p.quantity}개')
                        .toList();

                    return OrderListItem(
                      id: order.id,
                      orderNumber: order.orderNumber,
                      // 4. 날짜(DateTime)를 문자열로 직접 포맷팅합니다.
                      orderDate: DateFormat('yyyy.MM.dd').format(order.createdAt),
                      totalAmount: order.totalAmount,
                      status: order.status,
                      products: productSummaries, // 위에서 생성한 목록을 전달
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}