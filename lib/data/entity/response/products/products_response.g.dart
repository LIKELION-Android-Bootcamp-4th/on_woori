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
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ProductsResponseToJson(ProductsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp.toIso8601String(),
    };

ProductsData _$ProductsDataFromJson(Map<String, dynamic> json) => ProductsData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductsDataToJson(ProductsData instance) =>
    <String, dynamic>{'items': instance.items?.map((e) => e.toJson()).toList()};

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
  id: json['_id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  isFavorite: json['isFavorite'] as bool,
  images: _productImagesFromJson(json['images']),
  store: json['store'] == null
      ? null
      : StoreData.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'isFavorite': instance.isFavorite,
      'images': instance.images?.toJson(),
      'store': instance.store?.toJson(),
    };

ProductImages _$ProductImagesFromJson(Map<String, dynamic> json) =>
    ProductImages(main: json['main'] as String);

Map<String, dynamic> _$ProductImagesToJson(ProductImages instance) =>
    <String, dynamic>{'main': instance.main};

StoreData _$StoreDataFromJson(Map<String, dynamic> json) =>
    StoreData(id: json['id'] as String?, name: json['name'] as String);

Map<String, dynamic> _$StoreDataToJson(StoreData instance) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'name': instance.name,
};
