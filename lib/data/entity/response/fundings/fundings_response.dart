import 'package:json_annotation/json_annotation.dart';

part 'fundings_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FundingsResponse {
  final bool success;
  final String message;
  final List<FundingsItem>? data;

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
class FundingsItem {
  @JsonKey(name: 'id')
  final String id;
  final String title;
  final String imageUrl;
  final String linkUrl;
  final String? description;
  final CompanyId? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FundingsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
    this.description,
    this.companyId,
    this.createdAt,
    this.updatedAt,
  });

  factory FundingsItem.fromJson(Map<String, dynamic> json) =>
      _$FundingsItemFromJson(json);
  Map<String, dynamic> toJson() => _$FundingsItemToJson(this);
}

@JsonSerializable()
class CompanyId {
  @JsonKey(name: 'id')
  final String id;
  final String name;

  const CompanyId({
    required this.id,
    required this.name,
  });

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      _$CompanyIdFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyIdToJson(this);
}