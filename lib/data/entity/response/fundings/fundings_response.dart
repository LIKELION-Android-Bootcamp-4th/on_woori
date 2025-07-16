import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/seller/fundings/seller_funding_response.dart';

part 'fundings_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FundingsResponse {
  final bool success;
  final String message;
  final FundingData? data;

  const FundingsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory FundingsResponse.fromJson(Map<String, dynamic> json) =>
      _$FundingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FundingsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FundingData {
  final List<SellerFundingItem> items;
  final Pagination pagination;

  const FundingData({required this.items, required this.pagination});

  factory FundingData.fromJson(Map<String, dynamic> json) =>
      _$FundingDataFromJson(json);

  Map<String, dynamic> toJson() => _$FundingDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SellerFundingItem {
  @JsonKey(name: 'id')
  final String id;
  final String title;
  final String? imageUrl;
  final String? linkUrl;
  final String? thumbnailImageUrl;
  final String? description;
  final StoreId? storeId;
  final CompanyId? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? images; // images 필드 추가

  const SellerFundingItem({
    required this.id,
    required this.title,
    this.imageUrl,
    this.linkUrl,
    this.thumbnailImageUrl,
    this.description,
    this.storeId,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory SellerFundingItem.fromJson(Map<String, dynamic> json) =>
      _$SellerFundingItemFromJson(json);

  Map<String, dynamic> toJson() => _$SellerFundingItemToJson(this);
}

@JsonSerializable()
class CompanyId {
  @JsonKey(name: 'id')
  final String id;
  final String name;

  const CompanyId({required this.id, required this.name});

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      _$CompanyIdFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyIdToJson(this);
}

@JsonSerializable()
class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNext;
  final bool hasPrev;

  const Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
