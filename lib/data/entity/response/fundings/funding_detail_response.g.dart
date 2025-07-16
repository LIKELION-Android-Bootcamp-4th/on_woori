// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundingDetailResponse _$FundingDetailResponseFromJson(
  Map<String, dynamic> json,
) => FundingDetailResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : FundingDetailData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$FundingDetailResponseToJson(
  FundingDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
  'timestamp': instance.timestamp?.toIso8601String(),
};

FundingDetailData _$FundingDetailDataFromJson(Map<String, dynamic> json) =>
    FundingDetailData(
      id: json['id'] as String,
      title: json['title'] as String,
      linkUrl: json['linkUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FundingDetailDataToJson(FundingDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'linkUrl': instance.linkUrl,
      'imageUrl': instance.imageUrl,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
