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
      userId: json['userId'] == null
          ? null
          : UserId.fromJson(json['userId'] as Map<String, dynamic>),
      companyId: json['companyId'] == null
          ? null
          : CompanyId.fromJson(json['companyId'] as Map<String, dynamic>),
      storeId: json['storeId'] == null
          ? null
          : StoreId.fromJson(json['storeId'] as Map<String, dynamic>),
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
      'userId': instance.userId,
      'companyId': instance.companyId,
      'storeId': instance.storeId,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'targetAmount': instance.targetAmount,
      'currentAmount': instance.currentAmount,
      'endDate': instance.endDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

UserId _$UserIdFromJson(Map<String, dynamic> json) =>
    UserId(email: json['email'] as String, id: json['id'] as String);

Map<String, dynamic> _$UserIdToJson(UserId instance) => <String, dynamic>{
  'email': instance.email,
  'id': instance.id,
};

CompanyId _$CompanyIdFromJson(Map<String, dynamic> json) =>
    CompanyId(name: json['name'] as String);

Map<String, dynamic> _$CompanyIdToJson(CompanyId instance) => <String, dynamic>{
  'name': instance.name,
};

StoreId _$StoreIdFromJson(Map<String, dynamic> json) =>
    StoreId(name: json['name'] as String, id: json['id'] as String);

Map<String, dynamic> _$StoreIdToJson(StoreId instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
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
