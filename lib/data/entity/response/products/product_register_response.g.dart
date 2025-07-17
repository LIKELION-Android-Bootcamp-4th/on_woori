// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRegisterResponse _$ProductRegisterResponseFromJson(
  Map<String, dynamic> json,
) => ProductRegisterResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : ProductCreationData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$ProductRegisterResponseToJson(
  ProductRegisterResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
  'timestamp': instance.timestamp?.toIso8601String(),
};

ProductCreationData _$ProductCreationDataFromJson(Map<String, dynamic> json) =>
    ProductCreationData(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$ProductCreationDataToJson(
  ProductCreationData instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
