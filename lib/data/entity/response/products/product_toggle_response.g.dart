// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_toggle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductToggleResponse _$ProductToggleResponseFromJson(
  Map<String, dynamic> json,
) => ProductToggleResponse(
  success: json['success'] as bool,
  message: ToggleMessage.fromJson(json['message'] as Map<String, dynamic>),
  data: (json['data'] as num?)?.toInt(),
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$ProductToggleResponseToJson(
  ProductToggleResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message.toJson(),
  'data': instance.data,
  'timestamp': instance.timestamp?.toIso8601String(),
};

ToggleMessage _$ToggleMessageFromJson(Map<String, dynamic> json) =>
    ToggleMessage(
      code: json['code'] as String,
      message: json['message'] as String,
      result: ToggleResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ToggleMessageToJson(ToggleMessage instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result.toJson(),
    };

ToggleResult _$ToggleResultFromJson(Map<String, dynamic> json) => ToggleResult(
  productId: json['productId'] as String,
  isLiked: json['isLiked'] as bool,
  likeCount: (json['likeCount'] as num).toInt(),
  action: json['action'] as String,
);

Map<String, dynamic> _$ToggleResultToJson(ToggleResult instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'isLiked': instance.isLiked,
      'likeCount': instance.likeCount,
      'action': instance.action,
    };
