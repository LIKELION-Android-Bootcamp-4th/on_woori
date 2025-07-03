import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(24, 10, 24, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetailHeader(
                orderNumber: "000000000",
                orderDate: "2025-00-00",
                userName: "김이박",
              ),
              SizedBox(height: 10),
              Divider(color: Color(0xFFC9C9C9)),
              Text(
                "주문 상품",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),
              ListView.separated(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return OrderProductListItem(
                    imageUrl:
                        "https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg",
                    productName: "상품명",
                    options: "옵션옵션",
                    quantity: 1,
                    price: 168000,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(color: Color(0xFFC9C9C9)),
              ),
              SizedBox(height: 10),
              Divider(color: Color(0xFFC9C9C9)),
              Text(
                "결제 정보",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),
              PriceInfoBox(price: 16800, shippingFee: 0, totalPrice: 16800),
              SizedBox(height: 20),
              Divider(color: Color(0xFFC9C9C9)),
              Text(
                "배송지 정보",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),
              ShippingInfoBox(
                recipientName: "김이박",
                recipientPhone: "010-0000-0000",
                zipCode: 00000,
                address1: "서울특별시 --구 --동",
                address2: "0000호",
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderDetailHeader extends StatelessWidget {
  String orderNumber;
  String orderDate;
  String userName;

  OrderDetailHeader({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "주문번호 $orderNumber",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Text(
          "$orderDate | $userName",
          style: TextStyle(color: AppColors.grey, fontSize: 13),
        ),
      ],
    );
  }
}

class OrderProductListItem extends StatelessWidget {
  String imageUrl;
  String productName;
  String options;
  int quantity;
  int price;

  OrderProductListItem({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.options,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            // 상품 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "$options | $quantity개",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PriceInfoBox extends StatelessWidget {
  int price;
  int shippingFee;
  int totalPrice;

  PriceInfoBox({
    required this.price,
    required this.shippingFee,
    required this.totalPrice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
                "총 상품 금액",
                style: TextStyle(color: AppColors.grey, fontSize: 18),
              ),
              Text(
                "$price원",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "총 배송비",
                style: TextStyle(color: AppColors.grey, fontSize: 18),
              ),
              Text(
                "$shippingFee원",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Color(0xFFC9C9C9)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "결제 금액",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$totalPrice원",
                style: TextStyle(
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

class ShippingInfoBox extends StatelessWidget {
  String recipientName;
  String recipientPhone;
  int zipCode;
  String address1;
  String address2;

  ShippingInfoBox({
    required this.recipientName,
    required this.recipientPhone,
    required this.zipCode,
    required this.address1,
    required this.address2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
                "수령인",
                style: TextStyle(color: AppColors.grey, fontSize: 16),
              ),
              Text(
                recipientName,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "핸드폰",
                style: TextStyle(color: AppColors.grey, fontSize: 16),
              ),
              Text(
                recipientPhone,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Color(0xFFC9C9C9)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "우편번호",
                style: TextStyle(color: AppColors.grey, fontSize: 16),
              ),
              Text(
                "$zipCode",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("주소", style: TextStyle(color: AppColors.grey, fontSize: 16)),
              Text(
                address1,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "상세주소",
                style: TextStyle(color: AppColors.grey, fontSize: 16),
              ),
              Text(
                address2,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
