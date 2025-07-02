// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data.toJson(),
      'timestamp': instance.timestamp.toIso8601String(),
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
  isEmailVerified: json['isEmailVerified'] as bool,
  id: json['_id'] as String,
  email: json['email'] as String,
  nickName: json['nickName'] as String,
  profile: ProfileData.fromJson(json['profile'] as Map<String, dynamic>),
  platformRoles: (json['platformRoles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isAdmin: json['isAdmin'] as bool,
  companyId: json['companyId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  v: (json['__v'] as num).toInt(),
  isActive: json['isActive'] as bool,
  passwordChangedAt: DateTime.parse(json['passwordChangedAt'] as String),
  updatedBy: json['updatedBy'] as String,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'isEmailVerified': instance.isEmailVerified,
  '_id': instance.id,
  'email': instance.email,
  'nickName': instance.nickName,
  'profile': instance.profile.toJson(),
  'platformRoles': instance.platformRoles,
  'isAdmin': instance.isAdmin,
  'companyId': instance.companyId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  '__v': instance.v,
  'isActive': instance.isActive,
  'passwordChangedAt': instance.passwordChangedAt.toIso8601String(),
  'updatedBy': instance.updatedBy,
};

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  name: json['name'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  profileImage: json['profileImage'] as String?,
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'profileImage': instance.profileImage,
    };
