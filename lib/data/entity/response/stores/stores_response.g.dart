// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoresResponse _$StoresResponseFromJson(Map<String, dynamic> json) =>
    StoresResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => StoreItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$StoresResponseToJson(StoresResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'timestamp': instance.timestamp.toIso8601String(),
    };

StoreItem _$StoreItemFromJson(Map<String, dynamic> json) => StoreItem(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  owner: json['owner'] as String,
);

Map<String, dynamic> _$StoreItemToJson(StoreItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'owner': instance.owner,
};
