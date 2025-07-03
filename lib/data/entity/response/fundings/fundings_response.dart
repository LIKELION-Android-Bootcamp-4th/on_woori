
import 'package:json_annotation/json_annotation.dart';

part 'fundings_response.g.dart';

@JsonSerializable()
class FundingsResponse {
  final bool success;
  final String message;
  final FundingsData? data;

  const FundingsResponse({
    required this.success,
    required this.message,
    this.data
  });

  factory FundingsResponse.fromJson(Map<String, dynamic> json) =>
      _$FundingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FundingsResponseToJson(this);

}

@JsonSerializable(explicitToJson: true)
class FundingsData {
  final List<FundingsItem>? items;
  const FundingsData({this.items});

  factory FundingsData.fromJson(Map<String, dynamic> json) =>
      _$FundingsDataFromJson(json);
  Map<String, dynamic> toJson() => _$FundingsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FundingsItem {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String imageUrl;
  final String linkUrl;
  final String? descripition;
  final CompanyId? companyId;

  const FundingsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
    this.descripition,
    this.companyId
  });

  factory FundingsItem.fromJson(Map<String, dynamic> json) =>
      _$FundingsItemFromJson(json);
  Map<String, dynamic> toJson() => _$FundingsItemToJson(this);
}


@JsonSerializable()
class CompanyId {
  final String name;

  const CompanyId({
    required this.name
  });

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      _$CompanyIdFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyIdToJson(this);
}
