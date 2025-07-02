import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

// 최상위 응답 객체
@JsonSerializable(explicitToJson: true) // 중첩 객체가 있으므로 explicitToJson: true 추가
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

// 'data' 필드에 해당하는 객체
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
  final bool isEmailVerified;
  @JsonKey(name: '_id')
  final String id;
  final String email;
  final String nickName;
  final ProfileData profile;
  final List<String> platformRoles;
  final bool isAdmin;
  final String companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int v;
  final bool isActive;
  final DateTime passwordChangedAt;
  final String updatedBy;

  const UserData({
    required this.isEmailVerified,
    required this.id,
    required this.email,
    required this.nickName,
    required this.profile,
    required this.platformRoles,
    required this.isAdmin,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isActive,
    required this.passwordChangedAt,
    required this.updatedBy,
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