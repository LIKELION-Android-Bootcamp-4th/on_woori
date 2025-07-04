import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final bool success;
  final String message;
  final LoginData data;
  final DateTime timestamp;

  const LoginResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginData {
  final String accessToken;
  final String refreshToken;
  final UserData user;

  const LoginData({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserData {
  @JsonKey(name: '_id')
  final String id;
  final String email;
  final String? nickName;
  final ProfileData? profile;
  final List<String>? platformRoles;
  final bool? isAdmin;
  final bool? isActive;
  final bool? isEmailVerified;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  final DateTime? passwordChangedAt;
  final String? updatedBy;

  const UserData({
    required this.id,
    required this.email,
    this.nickName,
    this.profile,
    this.platformRoles,
    this.isAdmin,
    this.isActive,
    this.isEmailVerified,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.passwordChangedAt,
    this.updatedBy,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class ProfileData {
  final String? name;
  final DateTime? birthDate;
  final String? profileImage;

  const ProfileData({
    this.name,
    this.birthDate,
    this.profileImage,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}