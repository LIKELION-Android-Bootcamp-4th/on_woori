import 'package:json_annotation/json_annotation.dart';

part 'edit_funding_request.g.dart';

@JsonSerializable()
class EditFundingRequest {
  final String title;
  final String linkUrl;
  final String? imageUrl;

  EditFundingRequest({
    required this.title,
    required this.linkUrl,
    this.imageUrl,
  });

  factory EditFundingRequest.fromJson(Map<String, dynamic> json) =>
      _$EditFundingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditFundingRequestToJson(this);
}