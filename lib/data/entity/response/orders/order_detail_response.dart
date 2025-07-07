import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailResponse {
  final OrderDetailData? data;

  const OrderDetailResponse({this.data});

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderDetailData {
  final String orderNumber;
  final DateTime createdAt;
  final UserInfo userInfo;
  final List<OrderDetailProductItem> items;
  final int subtotalAmount;
  final int shippingCost;
  final int totalAmount;
  final ShippingInfo shippingInfo;

  String get orderDate => DateFormat('yyyy-MM-dd').format(createdAt);

  const OrderDetailData({
    required this.orderNumber,
    required this.createdAt,
    required this.userInfo,
    required this.items,
    required this.subtotalAmount,
    required this.shippingCost,
    required this.totalAmount,
    required this.shippingInfo,
  });

  factory OrderDetailData.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailDataToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String name;
  const UserInfo({required this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class OrderDetailProductItem {
  final String? productImage;
  final String productName;
  final Map<String, dynamic> options;
  final int quantity;
  final int totalPrice;

  String get optionsText {
    if (options.isEmpty) {
      return '선택 옵션 없음';
    }
    return options.entries.map((e) => '${e.key}: ${e.value}').join(', ');
  }

  const OrderDetailProductItem({
    this.productImage,
    required this.productName,
    required this.options,
    required this.quantity,
    required this.totalPrice,
  });

  factory OrderDetailProductItem.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailProductItemToJson(this);
}

@JsonSerializable()
class ShippingInfo {
  final String recipient;
  final String phone;
  final String zipCode;
  final String address;

  const ShippingInfo({
    required this.recipient,
    required this.phone,
    required this.zipCode,
    required this.address,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingInfoToJson(this);
}