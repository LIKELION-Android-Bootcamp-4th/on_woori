// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponse _$ProductsResponseFromJson(Map<String, dynamic> json) =>
    ProductsResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : ProductsData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ProductsResponseToJson(ProductsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };

ProductsData _$ProductsDataFromJson(Map<String, dynamic> json) => ProductsData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductsDataToJson(ProductsData instance) =>
    <String, dynamic>{'items': instance.items?.map((e) => e.toJson()).toList()};

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  isFavorite: json['isFavorite'] as bool?,
  stock: (json['stock'] as num?)?.toInt(),
  stockType: json['stockType'] as String?,
  discount: _discountToStringJson(json['discount']),
  status: json['status'] as String?,
  store: json['store'] == null
      ? null
      : StoreData.fromJson(json['store'] as Map<String, dynamic>),
  thumbnailImage: json['thumbnailImage'] == null
      ? null
      : ThumbnailImage.fromJson(json['thumbnailImage'] as Map<String, dynamic>),
  images: _imagesFromJson(json['images'] as String?),
  options: _optionsListFromJson(json['options'] as String?),
  category: json['category'] as String?,
);

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'isFavorite': instance.isFavorite,
      'stock': instance.stock,
      'stockType': instance.stockType,
      'discount': instance.discount,
      'status': instance.status,
      'store': instance.store?.toJson(),
      'thumbnailImage': instance.thumbnailImage?.toJson(),
      'category': instance.category,
      'images': instance.images?.toJson(),
      'options': instance.options?.map((e) => e.toJson()).toList(),
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

ProductOptionGroup _$ProductOptionGroupFromJson(Map<String, dynamic> json) =>
    ProductOptionGroup(
      type: json['type'] as String,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ProductOptionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductOptionGroupToJson(ProductOptionGroup instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

ProductOptionItem _$ProductOptionItemFromJson(Map<String, dynamic> json) =>
    ProductOptionItem(code: json['code'] as String);

Map<String, dynamic> _$ProductOptionItemToJson(ProductOptionItem instance) =>
    <String, dynamic>{'code': instance.code};

StoreData _$StoreDataFromJson(Map<String, dynamic> json) => StoreData(
  id: json['id'] as String?,
  name: json['name'] as String,
  owner: json['owner'] as String?,
  companyId: json['companyId'] as String?,
  thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
);

Map<String, dynamic> _$StoreDataToJson(StoreData instance) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'name': instance.name,
  'owner': instance.owner,
  'companyId': instance.companyId,
  'thumbnailImageUrl': instance.thumbnailImageUrl,
};
