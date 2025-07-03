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
  id: json['_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  owner: json['owner'] as String,
);

Map<String, dynamic> _$StoreItemToJson(StoreItem instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'owner': instance.owner,
};

StoreOwner _$StoreOwnerFromJson(Map<String, dynamic> json) => StoreOwner(
  id: json['_id'] as String,
  nickName: json['nickName'] as String,
  profile: StoreOwnerProfile.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoreOwnerToJson(StoreOwner instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nickName': instance.nickName,
      'profile': instance.profile,
    };

StoreDetailResponse _$StoreDetailResponseFromJson(Map<String, dynamic> json) =>
    StoreDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: StoreDetailItem.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$StoreDetailResponseToJson(
  StoreDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};

StoreDetailItem _$StoreDetailItemFromJson(Map<String, dynamic> json) =>
    StoreDetailItem(
      id: json['_id'] as String,
      name: json['name'] as String,
      owner: StoreOwner.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String,
    );

Map<String, dynamic> _$StoreDetailItemToJson(StoreDetailItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
      'description': instance.description,
    };

StoreOwnerProfile _$StoreOwnerProfileFromJson(Map<String, dynamic> json) =>
    StoreOwnerProfile(
      name: json['name'] as String,
      profileImage: json['profileImage'] as String,
    );

Map<String, dynamic> _$StoreOwnerProfileToJson(StoreOwnerProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profileImage': instance.profileImage,
    };

StoreProductsResponse _$StoreProductsResponseFromJson(
  Map<String, dynamic> json,
) => StoreProductsResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$StoreProductsResponseToJson(
  StoreProductsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};
