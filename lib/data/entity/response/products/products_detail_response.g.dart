// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsDetailResponse _$ProductsDetailResponseFromJson(
  Map<String, dynamic> json,
) => ProductsDetailResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: ProductsDetailData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$ProductsDetailResponseToJson(
  ProductsDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
  'timestamp': instance.timestamp.toIso8601String(),
};

ProductsDetailData _$ProductsDetailDataFromJson(Map<String, dynamic> json) =>
    ProductsDetailData(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      stockType: json['stockType'] as String,
      stock: (json['stock'] as num).toInt(),
      images: ProductImages.fromJson(json['images'] as Map<String, dynamic>),
      options: ProductOptions.fromJson(json['options'] as Map<String, dynamic>),
      discount: (json['discount'] as num?)?.toInt(),
      status: json['status'] as String,
      store: json['store'] == null
          ? null
          : StoreData.fromJson(json['store'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$ProductsDetailDataToJson(ProductsDetailData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'stockType': instance.stockType,
      'stock': instance.stock,
      'images': instance.images.toJson(),
      'options': instance.options.toJson(),
      'discount': instance.discount,
      'status': instance.status,
      'store': instance.store?.toJson(),
      'isFavorite': instance.isFavorite,
    };
