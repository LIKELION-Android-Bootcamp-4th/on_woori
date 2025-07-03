import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {

  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "주문상세조회",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Container(

      )
    );
  }
}