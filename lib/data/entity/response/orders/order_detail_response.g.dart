// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailResponse _$OrderDetailResponseFromJson(Map<String, dynamic> json) =>
    OrderDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : OrderDetailData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$OrderDetailResponseToJson(
  OrderDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
  'timestamp': instance.timestamp?.toIso8601String(),
};

OrderDetailData _$OrderDetailDataFromJson(Map<String, dynamic> json) =>
    OrderDetailData(
      id: json['id'] as String,
      userId: json['userId'] as String,
      companyId: json['companyId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toInt(),
      subtotalAmount: (json['subtotalAmount'] as num).toInt(),
      shippingCost: (json['shippingCost'] as num).toInt(),
      status: json['status'] as String,
      shippingInfo: ShippingInfo.fromJson(
        json['shippingInfo'] as Map<String, dynamic>,
      ),
      memo: json['memo'] as String?,
      orderDate: DateTime.parse(json['createdAt'] as String),
      orderNumber: json['orderNumber'] as String,
      statusHistory: (json['statusHistory'] as List<dynamic>?)
          ?.map((e) => StatusHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDetailDataToJson(OrderDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'companyId': instance.companyId,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'totalAmount': instance.totalAmount,
      'subtotalAmount': instance.subtotalAmount,
      'shippingCost': instance.shippingCost,
      'status': instance.status,
      'shippingInfo': instance.shippingInfo.toJson(),
      'memo': instance.memo,
      'createdAt': instance.orderDate.toIso8601String(),
      'orderNumber': instance.orderNumber,
      'statusHistory': instance.statusHistory?.map((e) => e.toJson()).toList(),
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  productId: json['id'] as String,
  productName: json['productName'] as String,
  quantity: (json['quantity'] as num).toInt(),
  unitPrice: (json['unitPrice'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num).toInt(),
  thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
  options: json['options'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.productId,
  'productName': instance.productName,
  'quantity': instance.quantity,
  'unitPrice': instance.unitPrice,
  'totalPrice': instance.totalPrice,
  'thumbnailImageUrl': instance.thumbnailImageUrl,
  'options': instance.options,
};

ShippingInfo _$ShippingInfoFromJson(Map<String, dynamic> json) => ShippingInfo(
  deliveryOption: json['deliveryOption'] as String?,
  freeShippingApplied: json['freeShippingApplied'] as bool?,
  shippingCostRatio: _shippingCostRatioFromJson(json['shippingCostRatio']),
);

Map<String, dynamic> _$ShippingInfoToJson(ShippingInfo instance) =>
    <String, dynamic>{
      'deliveryOption': instance.deliveryOption,
      'freeShippingApplied': instance.freeShippingApplied,
      'shippingCostRatio': instance.shippingCostRatio,
    };

OrderUserInfo _$OrderUserInfoFromJson(Map<String, dynamic> json) =>
    OrderUserInfo(
      id: json['id'] as String,
      name: json['nickName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$OrderUserInfoToJson(OrderUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickName': instance.name,
      'email': instance.email,
    };

StatusHistoryItem _$StatusHistoryItemFromJson(Map<String, dynamic> json) =>
    StatusHistoryItem(
      id: json['id'] as String,
      status: json['status'] as String,
      changedAt: DateTime.parse(json['changedAt'] as String),
      changedBy: json['changedBy'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$StatusHistoryItemToJson(StatusHistoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'changedAt': instance.changedAt.toIso8601String(),
      'changedBy': instance.changedBy,
      'note': instance.note,
    };
