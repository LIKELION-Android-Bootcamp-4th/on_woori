// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_funding_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditFundingRequest _$EditFundingRequestFromJson(Map<String, dynamic> json) =>
    EditFundingRequest(
      title: json['title'] as String,
      linkUrl: json['linkUrl'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$EditFundingRequestToJson(EditFundingRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'linkUrl': instance.linkUrl,
      'imageUrl': instance.imageUrl,
    };
