import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final bool success;
  final String message;
  final LoginData? data; // API 응답에 data가 없을 경우를 대비해 nullable 처리
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
  // [추가] API 응답에 있는 필드들을 추가합니다.
  @JsonKey(name: 'id')
  final String id;
  final String email;
  final String? nickName;
  final String? name;
  final String? phone;
  final String? phoneEncrypted;
  final ProfileData? profile;
  final List<String>? loginRoles;
  final List<String>? platformRoles;
  final bool? isAdmin;
  final bool? isSuperAdmin;
  final bool? isActive;
  final bool? needEmailVerification;
  final bool? emailVerified;
  final bool? isEmailVerified;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  const UserData({
    required this.id,
    required this.email,
    this.nickName,
    this.name,
    this.phone,
    this.phoneEncrypted,
    this.profile,
    this.loginRoles,
    this.platformRoles,
    this.isAdmin,
    this.isSuperAdmin,
    this.isActive,
    this.needEmailVerification,
    this.emailVerified,
    this.isEmailVerified,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileData {
  final String? name;
  final DateTime? birthDate;
  // [수정] profileImage 필드 타입을 String? 에서 ProfileImageData? 로 변경합니다.
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

// [추가] profileImage 객체를 파싱하기 위한 클래스
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
