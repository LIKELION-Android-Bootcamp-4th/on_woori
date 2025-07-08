// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  id: json['id'] as String,
  email: json['email'] as String,
  nickName: json['nickName'] as String?,
  profile: json['profile'] == null
      ? null
      : ProfileInfo.fromJson(json['profile'] as Map<String, dynamic>),
  loginRoles: (json['loginRoles'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isActive: json['isActive'] as bool?,
  needEmailVerification: json['needEmailVerification'] as bool?,
  emailVerified: json['emailVerified'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  address: json['address'] == null
      ? null
      : AddressData.fromJson(json['address'] as Map<String, dynamic>),
  phone: json['phone'] as String?,
  profileImage: json['profileImage'] as String?,
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickName': instance.nickName,
      'profile': instance.profile?.toJson(),
      'loginRoles': instance.loginRoles,
      'isActive': instance.isActive,
      'needEmailVerification': instance.needEmailVerification,
      'emailVerified': instance.emailVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'address': instance.address?.toJson(),
      'phone': instance.phone,
      'profileImage': instance.profileImage,
    };

ProfileInfo _$ProfileInfoFromJson(Map<String, dynamic> json) => ProfileInfo(
  name: json['name'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  profileImage: json['profileImage'] as String?,
);

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'profileImage': instance.profileImage,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
  zipCode: json['zipCode'] as String?,
  address1: json['address1'] as String?,
  address2: json['address2'] as String?,
);

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'zipCode': instance.zipCode,
      'address1': instance.address1,
      'address2': instance.address2,
    };
