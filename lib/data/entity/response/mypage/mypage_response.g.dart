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
  data: BuyerProfileData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BuyerProfileResponseToJson(
  BuyerProfileResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

BuyerProfileData _$BuyerProfileDataFromJson(Map<String, dynamic> json) =>
    BuyerProfileData(
      email: json['email'] as String,
      nickName: json['nickName'] as String,
      profile: BuyerProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuyerProfileDataToJson(BuyerProfileData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickName': instance.nickName,
      'profile': instance.profile.toJson(),
    };

BuyerProfile _$BuyerProfileFromJson(Map<String, dynamic> json) => BuyerProfile(
  name: json['name'] as String,
  birthDate: json['birthDate'] as String?,
  profileImage: json['profileImage'],
);

Map<String, dynamic> _$BuyerProfileToJson(BuyerProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDate': instance.birthDate,
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

ProfileImage _$ProfileImageFromJson(Map<String, dynamic> json) => ProfileImage(
  path: json['path'] as String?,
  realPath: json['realPath'] as String?,
  filename: json['filename'] as String?,
  originalName: json['originalName'] as String?,
  mimeType: json['mimeType'] as String?,
  size: (json['size'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProfileImageToJson(ProfileImage instance) =>
    <String, dynamic>{
      'path': instance.path,
      'realPath': instance.realPath,
      'filename': instance.filename,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
      'size': instance.size,
    };
