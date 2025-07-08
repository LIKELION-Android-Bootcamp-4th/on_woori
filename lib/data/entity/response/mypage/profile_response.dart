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
  final bool? isEmailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? phone;
  // [수정] 최상위 데이터에 있던 profileImage 필드 제거 (profile 객체 안에 있으므로)

  const ProfileData({
    required this.id,
    required this.email,
    this.nickName,
    this.profile,
    this.loginRoles,
    this.isActive,
    this.needEmailVerification,
    this.emailVerified,
    this.isEmailVerified,
    this.createdAt,
    this.updatedAt,
    this.phone,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}

// [수정] ProfileInfo가 ProfileImageData를 포함하므로 explicitToJson: true 추가
@JsonSerializable(explicitToJson: true)
class ProfileInfo {
  final String? name;
  final DateTime? birthDate;
  // [수정] profileImage 필드 타입을 String? 에서 ProfileImageData? 로 변경
  final ProfileImageData? profileImage;

  const ProfileInfo({
    this.name,
    this.birthDate,
    this.profileImage,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);
}

// [추가] profileImage 객체를 파싱하기 위한 클래스
@JsonSerializable()
class ProfileImageData {
  static const String baseUrl = 'http://git.hansul.kr:3002';

  final String? path;
  final String? realPath;
  final String? filename;
  final String? originalName;
  final String? mimeType;
  final int? size;

  String? get fullUrl {
    if (path != null && path!.isNotEmpty) {
      return '$baseUrl$path';
    }
    return null;
  }

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
