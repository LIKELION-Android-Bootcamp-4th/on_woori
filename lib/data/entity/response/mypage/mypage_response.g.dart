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
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      nickName: json['nickName'] as String,
      profileImage: json['profileImage'] as String,
      phone: json['phone'] as String,
      address: AddressData.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuyerProfileDataToJson(BuyerProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
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
