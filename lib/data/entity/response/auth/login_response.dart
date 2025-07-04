import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final bool success;
  final String message;
  final LoginData data;
  final DateTime? timestamp;

  const LoginResponse({
    required this.success,
    required this.message,
    required this.data,
    this.timestamp,
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
  final String id;
  final String email;
  final String? name;
  final String? nickName;
  final ProfileData? profile;
  final List<String>? platformRoles;
  final bool? isAdmin;
  final bool? isActive;
  final bool? isEmailVerified;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserData({
    required this.id,
    required this.email,
    this.name, // 생성자에 추가
    this.nickName,
    this.profile,
    this.platformRoles,
    this.isAdmin,
    this.isActive,
    this.isEmailVerified,
    this.companyId,
    this.createdAt,
    this.updatedAt,
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