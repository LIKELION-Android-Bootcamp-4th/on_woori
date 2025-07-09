// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : CartData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : CartPagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'pagination': instance.pagination?.toJson(),
};

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  id: json['id'] as String,
  product: CartProduct.fromJson(json['product'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num).toInt(),
  cartPrice: (json['cartPrice'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num).toInt(),
  storeId: json['storeId'] as String,
  storeName: json['storeName'] as String,
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'id': instance.id,
  'product': instance.product.toJson(),
  'quantity': instance.quantity,
  'cartPrice': instance.cartPrice,
  'totalPrice': instance.totalPrice,
  'storeId': instance.storeId,
  'storeName': instance.storeName,
};

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
  id: json['id'] as String,
  name: json['name'] as String,
  unitPrice: (json['unitPrice'] as num).toInt(),
  thumbnailImage: json['thumbnailImage'] as String?,
  options: (json['options'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
);

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unitPrice': instance.unitPrice,
      'thumbnailImage': instance.thumbnailImage,
      'options': instance.options,
    };

CartPagination _$CartPaginationFromJson(Map<String, dynamic> json) =>
    CartPagination(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      hasPrev: json['hasPrev'] as bool,
    );

Map<String, dynamic> _$CartPaginationToJson(CartPagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'limit': instance.limit,
      'hasNext': instance.hasNext,
      'hasPrev': instance.hasPrev,
    };
