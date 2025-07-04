// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fundings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundingsResponse _$FundingsResponseFromJson(Map<String, dynamic> json) =>
    FundingsResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FundingsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FundingsResponseToJson(FundingsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

FundingsItem _$FundingsItemFromJson(Map<String, dynamic> json) => FundingsItem(
  id: json['id'] as String,
  title: json['title'] as String,
  imageUrl: json['imageUrl'] as String,
  linkUrl: json['linkUrl'] as String,
  description: json['description'] as String?,
  companyId: json['companyId'] == null
      ? null
      : CompanyId.fromJson(json['companyId'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$FundingsItemToJson(FundingsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'description': instance.description,
      'companyId': instance.companyId?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

CompanyId _$CompanyIdFromJson(Map<String, dynamic> json) =>
    CompanyId(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$CompanyIdToJson(CompanyId instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
