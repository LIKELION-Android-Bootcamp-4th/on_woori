// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  user: UserData.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'user': instance.user.toJson(),
};

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  id: json['id'] as String?,
  email: json['email'] as String,
  profile: json['profile'] == null
      ? null
      : ProfileData.fromJson(json['profile'] as Map<String, dynamic>),
  nickName: json['nickName'] as String?,
  loginRoles: (json['loginRoles'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  platformRoles: (json['platformRoles'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isAdmin: json['isAdmin'] as bool?,
  isSuperAdmin: json['isSuperAdmin'] as bool?,
  isActive: json['isActive'] as bool?,
  needEmailVerification: json['needEmailVerification'] as bool?,
  emailVerified: json['emailVerified'] as bool?,
  companyId: json['companyId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  storeId: json['storeId'] as String?,
  userId: json['userId'] as String?,
  isWithdrawn: json['isWithdrawn'] as bool?,
  emailVerificationEnabled: json['emailVerificationEnabled'] as bool?,
  verificationCodeSent: json['verificationCodeSent'] as bool?,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'nickName': instance.nickName,
  'profile': instance.profile?.toJson(),
  'loginRoles': instance.loginRoles,
  'platformRoles': instance.platformRoles,
  'isAdmin': instance.isAdmin,
  'isSuperAdmin': instance.isSuperAdmin,
  'isActive': instance.isActive,
  'needEmailVerification': instance.needEmailVerification,
  'emailVerified': instance.emailVerified,
  'companyId': instance.companyId,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'storeId': instance.storeId,
  'userId': instance.userId,
  'isWithdrawn': instance.isWithdrawn,
  'emailVerificationEnabled': instance.emailVerificationEnabled,
  'verificationCodeSent': instance.verificationCodeSent,
};

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  name: json['name'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  profileImage: _profileImageFromJson(json['profileImage']),
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'profileImage': instance.profileImage,
    };

ProfileImageData _$ProfileImageDataFromJson(Map<String, dynamic> json) =>
    ProfileImageData(
      path: json['path'] as String?,
      realPath: json['realPath'] as String?,
      filename: json['filename'] as String?,
      originalName: json['originalName'] as String?,
      mimeType: json['mimeType'] as String?,
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileImageDataToJson(ProfileImageData instance) =>
    <String, dynamic>{
      'path': instance.path,
      'realPath': instance.realPath,
      'filename': instance.filename,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
      'size': instance.size,
    };
