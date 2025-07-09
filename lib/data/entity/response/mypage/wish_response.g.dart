// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishResponse _$WishResponseFromJson(Map<String, dynamic> json) => WishResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: WishData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$WishResponseToJson(WishResponse instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'success': instance.success,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };

WishData _$WishDataFromJson(Map<String, dynamic> json) => WishData(
  items: (json['items'] as List<dynamic>)
      .map((e) => WishlistItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WishDataToJson(WishData instance) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
};

WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) => WishlistItem(
  productId: Product.fromJson(json['productId'] as Map<String, dynamic>),
  store: Store.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WishlistItemToJson(WishlistItem instance) =>
    <String, dynamic>{
      'productId': instance.productId.toJson(),
      'store': instance.store.toJson(),
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  discountRate: json['discountRate'] as String,
  imageUrl: json['imageUrl'] as String,
  stockQuantity: (json['stockQuantity'] as num).toInt(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'discountRate': instance.discountRate,
  'imageUrl': instance.imageUrl,
  'stockQuantity': instance.stockQuantity,
};

Store _$StoreFromJson(Map<String, dynamic> json) =>
    Store(name: json['name'] as String);

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'name': instance.name,
};
