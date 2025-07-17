// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_funding_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateFundingRequest _$CreateFundingRequestFromJson(
  Map<String, dynamic> json,
) => CreateFundingRequest(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: FundingData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateFundingRequestToJson(
  CreateFundingRequest instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

FundingData _$FundingDataFromJson(Map<String, dynamic> json) => FundingData(
  id: json['id'] as String,
  storeId: StoreRef.fromJson(json['storeId'] as Map<String, dynamic>),
  title: json['title'] as String,
  linkUrl: json['linkUrl'] as String,
  imageUrl: json['imageUrl'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$FundingDataToJson(FundingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId.toJson(),
      'title': instance.title,
      'linkUrl': instance.linkUrl,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
    };

StoreRef _$StoreRefFromJson(Map<String, dynamic> json) =>
    StoreRef(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$StoreRefToJson(StoreRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
