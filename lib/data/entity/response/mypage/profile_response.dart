import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileResponse {
  final bool success;
  final String message;
  final ProfileData? data;
  final DateTime? timestamp;

  const ProfileResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileData {
  @JsonKey(name: 'id')
  final String id;
  final String email;
  final String? nickName;
  final ProfileInfo? profile;
  final List<String>? loginRoles;
  final bool? isActive;
  final bool? needEmailVerification;
  final bool? emailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final AddressData? address;
  final String? phone;
  final String? profileImage;

  const ProfileData({
    required this.id,
    required this.email,
    this.nickName,
    this.profile,
    this.loginRoles,
    this.isActive,
    this.needEmailVerification,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.phone,
    this.profileImage,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}

@JsonSerializable()
class ProfileInfo {
  final String? name;
  final DateTime? birthDate;
  final String? profileImage;

  const ProfileInfo({
    this.name,
    this.birthDate,
    this.profileImage,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);
}

@JsonSerializable()
class AddressData {
  final String? zipCode;
  final String? address1;
  final String? address2;

  const AddressData({
    this.zipCode,
    this.address1,
    this.address2,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}