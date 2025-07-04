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
  isFavorite: json['isFavorite'] as bool,
  stock: (json['stock'] as num?)?.toInt(),
  stockType: json['stockType'] as String?,
  discount: _discountFromJson(json['discount']),
  status: json['status'] as String?,
  images: _productImagesFromJson(json['images']),
  store: json['store'] == null
      ? null
      : StoreData.fromJson(json['store'] as Map<String, dynamic>),
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
      'images': instance.images?.toJson(),
      'store': instance.store?.toJson(),
    };

ProductImages _$ProductImagesFromJson(Map<String, dynamic> json) =>
    ProductImages(
      main: json['main'] as String,
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductImagesToJson(ProductImages instance) =>
    <String, dynamic>{'main': instance.main, 'detail': instance.detail};

ProductOptions _$ProductOptionsFromJson(Map<String, dynamic> json) =>
    ProductOptions(
      color: (json['color'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      size: (json['size'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductOptionsToJson(ProductOptions instance) =>
    <String, dynamic>{'color': instance.color, 'size': instance.size};

StoreData _$StoreDataFromJson(Map<String, dynamic> json) => StoreData(
  id: json['id'] as String?,
  name: json['name'] as String,
  owner: json['owner'] as String?,
  companyId: json['companyId'] as String?,
);

Map<String, dynamic> _$StoreDataToJson(StoreData instance) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'name': instance.name,
  'owner': instance.owner,
  'companyId': instance.companyId,
};
