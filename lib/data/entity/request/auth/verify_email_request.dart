import 'package:json_annotation/json_annotation.dart';

part 'verify_email_request.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifyEmailRequest {
  final String? email;

  final String? verificationCode;

  const VerifyEmailRequest({this.email, this.verificationCode});

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestToJson(this);
}
