import 'package:json_annotation/json_annotation.dart';

part 'mypage_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BuyerProfileResponse {
  final bool success;
  final String message;
  final BuyerProfileData data;

  const BuyerProfileResponse({
    required this.success,
    required this.message,
    required this.data
  });

  factory BuyerProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BuyerProfileData {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String email;
  final String nickName;
  final String profileImage;
  final String phone;
  final AddressData address;

  const BuyerProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.nickName,
    required this.profileImage,
    required this.phone,
    required this.address
  });

  factory BuyerProfileData.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressData {
  final String zipCode;
  final String address1;
  final String? address2;

  const AddressData({
    required this.zipCode,
    required this.address1,
    this.address2
  });

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}