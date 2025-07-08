// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishResponse _$WishResponseFromJson(Map<String, dynamic> json) => WishResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : WishData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$WishResponseToJson(WishResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };

WishData _$WishDataFromJson(Map<String, dynamic> json) => WishData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => WishlistItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WishDataToJson(WishData instance) => <String, dynamic>{
  'items': instance.items?.map((e) => e.toJson()).toList(),
};

WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) => WishlistItem(
  product: json['productId'] == null
      ? null
      : Product.fromJson(json['productId'] as Map<String, dynamic>),
  store: json['store'] == null
      ? null
      : Store.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WishlistItemToJson(WishlistItem instance) =>
    <String, dynamic>{
      'productId': instance.product?.toJson(),
      'store': instance.store?.toJson(),
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  isFavorite: json['isFavorite'] as bool?,
  stock: (json['stock'] as num?)?.toInt(),
  stockType: json['stockType'] as String?,
  discount: _discountToStringJson(json['discount']),
  status: json['status'] as String?,
  thumbnailImage: json['thumbnailImage'] == null
      ? null
      : ThumbnailImage.fromJson(json['thumbnailImage'] as Map<String, dynamic>),
  images: _imagesFromJson(json['images'] as String?),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'isFavorite': instance.isFavorite,
  'stock': instance.stock,
  'stockType': instance.stockType,
  'discount': instance.discount,
  'status': instance.status,
  'thumbnailImage': instance.thumbnailImage?.toJson(),
  'images': instance.images?.toJson(),
};

ThumbnailImage _$ThumbnailImageFromJson(Map<String, dynamic> json) =>
    ThumbnailImage(id: json['id'] as String, url: json['url'] as String);

Map<String, dynamic> _$ThumbnailImageToJson(ThumbnailImage instance) =>
    <String, dynamic>{'id': instance.id, 'url': instance.url};

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
  detail: (json['detail'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
  'detail': instance.detail,
};

Store _$StoreFromJson(Map<String, dynamic> json) =>
    Store(name: json['name'] as String);

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'name': instance.name,
};
