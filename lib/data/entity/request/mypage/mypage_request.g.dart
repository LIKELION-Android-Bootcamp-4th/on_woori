// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyerProfileEditRequest _$BuyerProfileEditRequestFromJson(
  Map<String, dynamic> json,
) => BuyerProfileEditRequest(
  nickName: json['nickName'] as String,
  profileImage: json['profileImage'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] == null
      ? null
      : AddressData.fromJson(json['address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BuyerProfileEditRequestToJson(
  BuyerProfileEditRequest instance,
) => <String, dynamic>{
  'nickName': instance.nickName,
  'profileImage': instance.profileImage,
  'phone': instance.phone,
  'address': instance.address?.toJson(),
};
