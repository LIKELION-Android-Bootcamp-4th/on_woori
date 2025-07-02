import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResponse {
  final String code;
  final String message;
  final RegisterResult result;

  const RegisterResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class RegisterResult {
  final String userId;
  final String email;
  final String nickName;
  final bool isEmailVerified;
  final bool verificationCodeSent;

  const RegisterResult({
    required this.userId,
    required this.email,
    required this.nickName,
    required this.isEmailVerified,
    required this.verificationCodeSent,
  });

  factory RegisterResult.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResultToJson(this);
}