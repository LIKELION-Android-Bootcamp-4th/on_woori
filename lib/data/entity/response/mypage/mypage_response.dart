import 'package:json_annotation/json_annotation.dart';

part 'mypage_response.g.dart';

ProfileImageData? _profileImageFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return ProfileImageData.fromJson(json);
  }
  return null;
}

@JsonSerializable(explicitToJson: true)
class BuyerProfileResponse {
  final bool success;
  final String message;
  final BuyerProfileData? data;

  const BuyerProfileResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BuyerProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BuyerProfileData {
  @JsonKey(name: 'id')
  final String id;
  final String email;
  final String? nickName;
  final ProfileData profile;
  final List<String>? loginRoles;
  final bool? isActive;
  final bool? needEmailVerification;
  final bool? emailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  const BuyerProfileData({
    required this.id,
    required this.email,
    required this.profile,
    this.nickName,
    this.loginRoles,
    this.isActive,
    this.needEmailVerification,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory BuyerProfileData.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileDataToJson(this);
}

@JsonSerializable()
class ProfileData {
  final String? name;
  final DateTime? birthDate;

  @JsonKey(fromJson: _profileImageFromJson)
  final ProfileImageData? profileImage;

  const ProfileData({
    this.name,
    this.birthDate,
    this.profileImage,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
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

@JsonSerializable()
class ProfileImageData {
  final String? path;
  final String? realPath;
  final String? filename;
  final String? originalName;
  final String? mimeType;
  final int? size;

  const ProfileImageData({
    this.path,
    this.realPath,
    this.filename,
    this.originalName,
    this.mimeType,
    this.size
  });

  factory ProfileImageData.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileImageDataToJson(this);
}