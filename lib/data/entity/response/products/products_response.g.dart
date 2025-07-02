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
  stockType: json['stockType'] as String,
  stock: (json['stock'] as num).toInt(),
  images: json['images'] == null
      ? null
      : ProductImages.fromJson(json['images'] as Map<String, dynamic>),
  options: json['options'] == null
      ? null
      : ProductOptions.fromJson(json['options'] as Map<String, dynamic>),
  discount: (json['discount'] as num?)?.toInt(),
  status: json['status'] as String,
  store: json['store'] == null
      ? null
      : StoreData.fromJson(json['store'] as Map<String, dynamic>),
  isFavorite: json['isFavorite'] as bool,
);

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'stockType': instance.stockType,
      'stock': instance.stock,
      'images': instance.images?.toJson(),
      'options': instance.options?.toJson(),
      'discount': instance.discount,
      'status': instance.status,
      'store': instance.store?.toJson(),
      'isFavorite': instance.isFavorite,
    };

ProductImages _$ProductImagesFromJson(Map<String, dynamic> json) =>
    ProductImages(
      main: json['main'] as String,
      sub: (json['sub'] as List<dynamic>?)?.map((e) => e as String).toList(),
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductImagesToJson(ProductImages instance) =>
    <String, dynamic>{
      'main': instance.main,
      'sub': instance.sub,
      'detail': instance.detail,
    };

ProductOptions _$ProductOptionsFromJson(Map<String, dynamic> json) =>
    ProductOptions(
      color: (json['color'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductOptionsToJson(ProductOptions instance) =>
    <String, dynamic>{'color': instance.color};

StoreData _$StoreDataFromJson(Map<String, dynamic> json) => StoreData(
  id: json['id'] as String?,
  name: json['name'] as String,
  owner: json['owner'] as String,
  companyId: json['companyId'] as String,
  status: json['status'] as String?,
);

Map<String, dynamic> _$StoreDataToJson(StoreData instance) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'name': instance.name,
  'owner': instance.owner,
  'companyId': instance.companyId,
  'status': instance.status,
};
