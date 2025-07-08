import 'package:json_annotation/json_annotation.dart';

part 'create_funding_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateFundingRequest {
  final bool success;
  final String message;
  final FundingData data;

  const CreateFundingRequest({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreateFundingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFundingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateFundingRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FundingData {
  @JsonKey(name: 'id')
  final String id;
  final String storeId;
  final String title;
  final String linkUrl;
  final String? imageUrl;
  final String? createdAt;

  const FundingData({
    required this.id,
    required this.storeId,
    required this.title,
    required this.linkUrl,
    this.imageUrl,
    this.createdAt,
  });

  factory FundingData.fromJson(Map<String, dynamic> json) =>
      _$FundingDataFromJson(json);
  Map<String, dynamic> toJson() => _$FundingDataToJson(this);
}