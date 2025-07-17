import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

ProfileImageData? _profileImageFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return ProfileImageData.fromJson(json);
  }
  return null;
}

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final bool success;
  final String message;
  final LoginData? data;
  final DateTime? timestamp;

  const LoginResponse({
    required this.success,
    required this.message,
    this.data,
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
  // ✅ [수정] 판매자 회원가입 응답에 id가 없으므로 nullable로 변경
  @JsonKey(name: 'id')
  final String? id;

  final String email;
  final String? nickName;
  final ProfileData? profile;
  final List<String>? loginRoles;
  final List<String>? platformRoles;
  final bool? isAdmin;
  final bool? isSuperAdmin;
  final bool? isActive;
  final bool? needEmailVerification;
  final bool? emailVerified;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // 로그인/회원가입 응답 차이를 모두 수용하기 위한 nullable 필드들
  final String? storeId;
  final String? userId;
  final bool? isWithdrawn;
  final bool? emailVerificationEnabled;
  final bool? verificationCodeSent;

  const UserData({
    // ✅ [수정] 생성자에서 id의 required 키워드 제거
    this.id,

    required this.email,
    this.profile,
    this.nickName,
    this.loginRoles,
    this.platformRoles,
    this.isAdmin,
    this.isSuperAdmin,
    this.isActive,
    this.needEmailVerification,
    this.emailVerified,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.storeId,
    this.userId,
    this.isWithdrawn,
    this.emailVerificationEnabled,
    this.verificationCodeSent,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class ProfileData {
  final String? name;
  final DateTime? birthDate;

  @JsonKey(fromJson: _profileImageFromJson)
  final ProfileImageData? profileImage;

  const ProfileData({this.name, this.birthDate, this.profileImage});

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
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
    this.size,
  });

  factory ProfileImageData.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageDataToJson(this);
}
