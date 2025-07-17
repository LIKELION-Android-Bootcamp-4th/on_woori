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

@JsonSerializable(explicitToJson: true)
class FundingDetailData {
  @JsonKey(name: 'id')
  final String id;
  final String title;
  final String? linkUrl;
  final String? imageUrl;
  final String? thumbnailImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  const FundingDetailData({
    required this.id,
    required this.title,
    this.linkUrl,
    this.imageUrl,
    this.thumbnailImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory FundingDetailData.fromJson(Map<String, dynamic> json) =>
      _$FundingDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$FundingDetailDataToJson(this);
}
