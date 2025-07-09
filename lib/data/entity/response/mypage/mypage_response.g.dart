// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyerProfileResponse _$BuyerProfileResponseFromJson(
  Map<String, dynamic> json,
) => BuyerProfileResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : BuyerProfileData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BuyerProfileResponseToJson(
  BuyerProfileResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
};

BuyerProfileData _$BuyerProfileDataFromJson(Map<String, dynamic> json) =>
    BuyerProfileData(
      id: json['id'] as String,
      email: json['email'] as String,
      profile: ProfileData.fromJson(json['profile'] as Map<String, dynamic>),
      nickName: json['nickName'] as String?,
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
    );

Map<String, dynamic> _$BuyerProfileDataToJson(BuyerProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickName': instance.nickName,
      'profile': instance.profile.toJson(),
      'loginRoles': instance.loginRoles,
      'isActive': instance.isActive,
      'needEmailVerification': instance.needEmailVerification,
      'emailVerified': instance.emailVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
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

BuyerProfileEditResponse _$BuyerProfileEditResponseFromJson(
  Map<String, dynamic> json,
) => BuyerProfileEditResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: BuyerProfileEditedData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BuyerProfileEditResponseToJson(
  BuyerProfileEditResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

BuyerProfileEditedData _$BuyerProfileEditedDataFromJson(
  Map<String, dynamic> json,
) => BuyerProfileEditedData(
  nickName: json['nickName'] as String,
  profileImage: json['profileImage'],
  phone: json['phone'] as String,
  address: AddressData.fromJson(json['address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BuyerProfileEditedDataToJson(
  BuyerProfileEditedData instance,
) => <String, dynamic>{
  'nickName': instance.nickName,
  'profileImage': instance.profileImage,
  'phone': instance.phone,
  'address': instance.address.toJson(),
};

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
  zipCode: json['zipCode'] as String,
  address1: json['address1'] as String,
  address2: json['address2'] as String?,
);

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'zipCode': instance.zipCode,
      'address1': instance.address1,
      'address2': instance.address2,
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
