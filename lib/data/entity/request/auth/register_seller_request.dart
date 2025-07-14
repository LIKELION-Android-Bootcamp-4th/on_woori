import 'package:json_annotation/json_annotation.dart';

part 'register_seller_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterSellerRequest {
  final String email;
  final String password;
  final String nickName;
  final StoreRequestData store;

  const RegisterSellerRequest({
    required this.email,
    required this.password,
    required this.nickName,
    required this.store,
  });

  factory RegisterSellerRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterSellerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterSellerRequestToJson(this);
}

@JsonSerializable()
class StoreRequestData {
  final String name;
  final String description;

  const StoreRequestData({required this.name, required this.description});

  factory StoreRequestData.fromJson(Map<String, dynamic> json) =>
      _$StoreRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$StoreRequestDataToJson(this);
}
