// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersResponse _$OrdersResponseFromJson(Map<String, dynamic> json) =>
    OrdersResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: OrdersData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$OrdersResponseToJson(OrdersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data.toJson(),
      'timestamp': instance.timestamp.toIso8601String(),
    };

OrdersData _$OrdersDataFromJson(Map<String, dynamic> json) => OrdersData(
  orders: (json['items'] as List<dynamic>)
      .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: PaginationData.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$OrdersDataToJson(OrdersData instance) =>
    <String, dynamic>{
      'items': instance.orders.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination.toJson(),
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  id: json['id'] as String,
  orderNumber: json['orderNumber'] as String,
  totalAmount: (json['totalAmount'] as num).toInt(),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  products: (json['items'] as List<dynamic>)
      .map((e) => OrderedProductItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.id,
  'orderNumber': instance.orderNumber,
  'totalAmount': instance.totalAmount,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'items': instance.products.map((e) => e.toJson()).toList(),
};

OrderedProductItem _$OrderedProductItemFromJson(Map<String, dynamic> json) =>
    OrderedProductItem(
      id: json['id'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderedProductItemToJson(OrderedProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'quantity': instance.quantity,
    };

ProductId _$ProductIdFromJson(Map<String, dynamic> json) =>
    ProductId(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$ProductIdToJson(ProductId instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

PaginationData _$PaginationDataFromJson(Map<String, dynamic> json) =>
    PaginationData(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      hasPrev: json['hasPrev'] as bool,
    );

Map<String, dynamic> _$PaginationDataToJson(PaginationData instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'hasNext': instance.hasNext,
      'hasPrev': instance.hasPrev,
    };
