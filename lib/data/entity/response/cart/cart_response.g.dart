// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
  data: json['data'] == null
      ? null
      : CartData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{'data': instance.data?.toJson()};

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  id: json['id'] as String,
  product: CartProduct.fromJson(json['product'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num).toInt(),
  cartPrice: (json['cartPrice'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num).toInt(),
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'id': instance.id,
  'product': instance.product.toJson(),
  'quantity': instance.quantity,
  'cartPrice': instance.cartPrice,
  'totalPrice': instance.totalPrice,
};

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
  name: json['name'] as String,
  thumbnailImage: json['thumbnailImage'] as String?,
  options: (json['options'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'thumbnailImage': instance.thumbnailImage,
      'options': instance.options,
    };
