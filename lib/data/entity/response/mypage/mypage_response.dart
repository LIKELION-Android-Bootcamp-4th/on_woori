import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/auth/login_response.dart';

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
  final String email;
  final String nickName;
  final BuyerProfile profile;

  const BuyerProfileData({
    required this.email,
    required this.nickName,
    required this.profile
  });

  factory BuyerProfileData.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BuyerProfile {
  final String name;
  final String? birthDate;
  final Object? profileImage;

  const BuyerProfile({
    required this.name,
    this.birthDate,
    this.profileImage
  });

  factory BuyerProfile.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BuyerProfileEditResponse {
  final bool success;
  final String message;
  final BuyerProfileEditedData data;

  const BuyerProfileEditResponse({
    required this.success,
    required this.message,
    required this.data
  });

  factory BuyerProfileEditResponse.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileEditResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileEditResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BuyerProfileEditedData {
  final String nickName;
  final Object? profileImage;
  final String phone;
  final AddressData address;

  const BuyerProfileEditedData({
    required this.nickName,
    required this.profileImage,
    required this.phone,
    required this.address
  });

  factory BuyerProfileEditedData.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileEditedDataFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileEditedDataToJson(this);
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

@JsonSerializable(explicitToJson: true)
class ProfileImage {
  final String? path;
  final String? realPath;
  final String? filename;
  final String? originalName;
  final String? mimeType;
  final int? size;

  const ProfileImage({
    this.path,
    this.realPath,
    this.filename,
    this.originalName,
    this.mimeType,
    this.size
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileImageToJson(this);
}