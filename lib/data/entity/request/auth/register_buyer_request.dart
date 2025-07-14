import 'package:json_annotation/json_annotation.dart';

part 'register_buyer_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterBuyerRequest {
  final String email;
  final String password;
  final String nickName;

  const RegisterBuyerRequest({
    required this.email,
    required this.password,
    required this.nickName,
  });

  factory RegisterBuyerRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterBuyerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterBuyerRequestToJson(this);
}
