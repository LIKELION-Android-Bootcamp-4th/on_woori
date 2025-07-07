// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_seller_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterSellerRequest _$RegisterSellerRequestFromJson(
  Map<String, dynamic> json,
) => RegisterSellerRequest(
  email: json['email'] as String,
  password: json['password'] as String,
  nickName: json['nickName'] as String,
  store: StoreRequestData.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RegisterSellerRequestToJson(
  RegisterSellerRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'nickName': instance.nickName,
  'store': instance.store.toJson(),
};

StoreRequestData _$StoreRequestDataFromJson(Map<String, dynamic> json) =>
    StoreRequestData(
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$StoreRequestDataToJson(StoreRequestData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
