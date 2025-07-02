
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
  final int stock;

  const FundingsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
    required this.stock,
  });

  factory FundingsItem.fromJson(Map<String, dynamic> json) =>
      _$FundingsItemFromJson(json);
  Map<String, dynamic> toJson() => _$FundingsItemToJson(this);

}


@JsonSerializable()
class CompanyItem {
  final String name;

  const CompanyItem({
    required this.name
  });

  factory CompanyItem.fromJson(Map<String, dynamic> json) =>
      _$CompanyItemFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyItemToJson(this);
}
