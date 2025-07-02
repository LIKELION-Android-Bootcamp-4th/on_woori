// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_buyer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBuyerRequest _$RegisterBuyerRequestFromJson(
  Map<String, dynamic> json,
) => RegisterBuyerRequest(
  email: json['email'] as String,
  password: json['password'] as String,
  nickName: json['nickName'] as String,
);

Map<String, dynamic> _$RegisterBuyerRequestToJson(
  RegisterBuyerRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'nickName': instance.nickName,
};
