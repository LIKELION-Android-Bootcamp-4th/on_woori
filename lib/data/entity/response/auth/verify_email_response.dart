import 'package:json_annotation/json_annotation.dart';

part 'verify_email_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifyEmailResponse {
  final String code;
  final String message;
  final VerifyResult result;

  const VerifyEmailResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailResponseToJson(this);
}

@JsonSerializable()
class VerifyResult {
  final String userId;
  final bool isEmailVerified;

  const VerifyResult({
    required this.userId,
    required this.isEmailVerified,
  });

  factory VerifyResult.fromJson(Map<String, dynamic> json) =>
      _$VerifyResultFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResultToJson(this);
}