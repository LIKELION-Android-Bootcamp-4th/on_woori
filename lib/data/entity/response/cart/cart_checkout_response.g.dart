// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartCheckoutResponse _$CartCheckoutResponseFromJson(
  Map<String, dynamic> json,
) => CartCheckoutResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$CartCheckoutResponseToJson(
  CartCheckoutResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'timestamp': instance.timestamp?.toIso8601String(),
};
