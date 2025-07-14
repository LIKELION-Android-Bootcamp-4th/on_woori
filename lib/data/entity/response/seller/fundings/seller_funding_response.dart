import 'package:json_annotation/json_annotation.dart';

part 'seller_funding_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SellerFundingResponse {
  final bool success;
  final String message;
  final FundingData? data;

  const SellerFundingResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory SellerFundingResponse.fromJson(Map<String, dynamic> json) =>
      _$SellerFundingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SellerFundingResponseToJson(this);
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

@JsonSerializable()
class SellerFundingItem {
  @JsonKey(name: 'id')
  final String id;

  final String title;
  final String? imageUrl;
  final String? linkUrl;
  final CompanyId? companyId;

  @JsonKey(fromJson: _toInt)
  final int? targetAmount;

  @JsonKey(fromJson: _toInt)
  final int? currentAmount;

  @JsonKey(fromJson: _parseDate)
  final DateTime? endDate;

  @JsonKey(fromJson: _parseDate)
  final DateTime? createdAt;

  const SellerFundingItem({
    required this.id,
    required this.title,
    this.imageUrl,
    this.linkUrl,
    this.companyId,
    this.targetAmount,
    this.currentAmount,
    this.endDate,
    this.createdAt,
  });

  factory SellerFundingItem.fromJson(Map<String, dynamic> json) =>
      _$SellerFundingItemFromJson(json);

  Map<String, dynamic> toJson() => _$SellerFundingItemToJson(this);

  // 🔧 커스텀 파서들
  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

@JsonSerializable()
class CompanyId {
  final String name;

  const CompanyId({required this.name});

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      _$CompanyIdFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyIdToJson(this);
}

@JsonSerializable()
class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNext;
  final bool hasPrev;

  const Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
