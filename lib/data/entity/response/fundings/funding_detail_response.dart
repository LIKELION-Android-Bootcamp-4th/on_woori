import 'package:json_annotation/json_annotation.dart';

part 'funding_detail_response.g.dart';

// 최상위 응답 구조
@JsonSerializable(explicitToJson: true)
class FundingDetailResponse {
  final bool success;
  final String message;
  final FundingDetailData? data;
  final DateTime? timestamp;

  const FundingDetailResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory FundingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$FundingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FundingDetailResponseToJson(this);
}

// "data" 필드의 객체 구조
@JsonSerializable(explicitToJson: true)
class FundingDetailData {
  @JsonKey(name: 'id')
  final String id;
  final String title;
  final String? linkUrl;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // 필요하다면 다른 필드들도 추가할 수 있습니다.
  // final FundingCompanyInfo? companyId;

  const FundingDetailData({
    required this.id,
    required this.title,
    this.linkUrl,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory FundingDetailData.fromJson(Map<String, dynamic> json) =>
      _$FundingDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$FundingDetailDataToJson(this);
}