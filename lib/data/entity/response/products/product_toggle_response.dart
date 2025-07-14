import 'package:json_annotation/json_annotation.dart';

part 'product_toggle_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductToggleResponse {
  final bool success;
  final ToggleMessage message;
  final int? data;
  final DateTime? timestamp;

  const ProductToggleResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory ProductToggleResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductToggleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToggleResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ToggleMessage {
  final String code;
  final String message;
  final ToggleResult result;

  const ToggleMessage({
    required this.code,
    required this.message,
    required this.result,
  });

  factory ToggleMessage.fromJson(Map<String, dynamic> json) =>
      _$ToggleMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleMessageToJson(this);
}

@JsonSerializable()
class ToggleResult {
  final String productId;
  final bool isLiked;
  final int likeCount;
  final String action;

  const ToggleResult({
    required this.productId,
    required this.isLiked,
    required this.likeCount,
    required this.action,
  });

  factory ToggleResult.fromJson(Map<String, dynamic> json) =>
      _$ToggleResultFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleResultToJson(this);
}
