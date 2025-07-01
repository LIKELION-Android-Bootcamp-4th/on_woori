import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(includeIfNull:  false)
  final String? email;

  @JsonKey(includeIfNull: false)
  final String? password;

  @JsonKey(name: 'accessToken', includeIfNull: false)
  final String? accessToken;

  const LoginRequest({
    this.email,
    this.password,
    this.accessToken,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}