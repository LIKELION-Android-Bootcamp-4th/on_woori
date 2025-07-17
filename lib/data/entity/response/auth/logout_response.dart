import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LogoutResponse {
  final bool success;
  final String message;
  final DateTime? timestamp;

  const LogoutResponse({
    required this.success,
    required this.message,
    this.timestamp,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);
}
