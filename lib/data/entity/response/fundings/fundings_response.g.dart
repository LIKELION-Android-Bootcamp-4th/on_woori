// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fundings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundingsResponse _$FundingsResponseFromJson(Map<String, dynamic> json) =>
    FundingsResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : FundingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FundingsResponseToJson(FundingsResponse instance) =>
    <String, dynamic>{
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
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
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
      images: json['images'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SellerFundingItemToJson(SellerFundingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'description': instance.description,
      'companyId': instance.companyId?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'images': instance.images,
    };

CompanyId _$CompanyIdFromJson(Map<String, dynamic> json) =>
    CompanyId(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$CompanyIdToJson(CompanyId instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalItems: (json['totalItems'] as num).toInt(),
  itemsPerPage: (json['itemsPerPage'] as num).toInt(),
  hasNext: json['hasNext'] as bool,
  hasPrev: json['hasPrev'] as bool,
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'itemsPerPage': instance.itemsPerPage,
      'hasNext': instance.hasNext,
      'hasPrev': instance.hasPrev,
    };
