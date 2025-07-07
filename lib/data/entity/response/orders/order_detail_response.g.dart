// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailResponse _$OrderDetailResponseFromJson(Map<String, dynamic> json) =>
    OrderDetailResponse(
      data: json['data'] == null
          ? null
          : OrderDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailResponseToJson(
  OrderDetailResponse instance,
) => <String, dynamic>{'data': instance.data?.toJson()};

OrderDetailData _$OrderDetailDataFromJson(Map<String, dynamic> json) =>
    OrderDetailData(
      orderNumber: json['orderNumber'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map(
            (e) => OrderDetailProductItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      subtotalAmount: (json['subtotalAmount'] as num).toInt(),
      shippingCost: (json['shippingCost'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toInt(),
      shippingInfo: ShippingInfo.fromJson(
        json['shippingInfo'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$OrderDetailDataToJson(OrderDetailData instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'userInfo': instance.userInfo.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'subtotalAmount': instance.subtotalAmount,
      'shippingCost': instance.shippingCost,
      'totalAmount': instance.totalAmount,
      'shippingInfo': instance.shippingInfo.toJson(),
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) =>
    UserInfo(name: json['name'] as String);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'name': instance.name,
};

OrderDetailProductItem _$OrderDetailProductItemFromJson(
  Map<String, dynamic> json,
) => OrderDetailProductItem(
  productImage: json['productImage'] as String?,
  productName: json['productName'] as String,
  options: json['options'] as Map<String, dynamic>,
  quantity: (json['quantity'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num).toInt(),
);

Map<String, dynamic> _$OrderDetailProductItemToJson(
  OrderDetailProductItem instance,
) => <String, dynamic>{
  'productImage': instance.productImage,
  'productName': instance.productName,
  'options': instance.options,
  'quantity': instance.quantity,
  'totalPrice': instance.totalPrice,
};

ShippingInfo _$ShippingInfoFromJson(Map<String, dynamic> json) => ShippingInfo(
  recipient: json['recipient'] as String,
  phone: json['phone'] as String,
  zipCode: json['zipCode'] as String,
  address: json['address'] as String,
);

Map<String, dynamic> _$ShippingInfoToJson(ShippingInfo instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'address': instance.address,
    };
