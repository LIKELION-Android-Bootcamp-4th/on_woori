// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_funding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerFundingResponse _$SellerFundingResponseFromJson(
  Map<String, dynamic> json,
) => SellerFundingResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : FundingData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SellerFundingResponseToJson(
  SellerFundingResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
};

FundingData _$FundingDataFromJson(Map<String, dynamic> json) => FundingData(
  items: (json['items'] as List<dynamic>)
      .map((e) => SellerFundingItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FundingDataToJson(FundingData instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination.toJson(),
    };

SellerFundingItem _$SellerFundingItemFromJson(Map<String, dynamic> json) =>
    SellerFundingItem(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      companyId: json['companyId'] == null
          ? null
          : CompanyId.fromJson(json['companyId'] as Map<String, dynamic>),
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      targetAmount: SellerFundingItem._toInt(json['targetAmount']),
      currentAmount: SellerFundingItem._toInt(json['currentAmount']),
      endDate: SellerFundingItem._parseDate(json['endDate']),
      createdAt: SellerFundingItem._parseDate(json['createdAt']),
    );

Map<String, dynamic> _$SellerFundingItemToJson(SellerFundingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'companyId': instance.companyId,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'targetAmount': instance.targetAmount,
      'currentAmount': instance.currentAmount,
      'endDate': instance.endDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

CompanyId _$CompanyIdFromJson(Map<String, dynamic> json) =>
    CompanyId(name: json['name'] as String);

Map<String, dynamic> _$CompanyIdToJson(CompanyId instance) => <String, dynamic>{
  'name': instance.name,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalItems: (json['totalItems'] as num).toInt(),
  hasNext: json['hasNext'] as bool,
  hasPrev: json['hasPrev'] as bool,
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'hasNext': instance.hasNext,
      'hasPrev': instance.hasPrev,
    };
