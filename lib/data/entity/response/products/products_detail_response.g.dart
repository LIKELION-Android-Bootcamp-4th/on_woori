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
  data: json['data'] == null
      ? null
      : ProductItem.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductsDetailResponseToJson(
  ProductsDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
};
