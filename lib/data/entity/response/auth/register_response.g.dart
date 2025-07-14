// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      message: json['message'] as String,
      result: RegisterResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result.toJson(),
    };

RegisterResult _$RegisterResultFromJson(Map<String, dynamic> json) =>
    RegisterResult(
      userId: json['userId'] as String,
      email: json['email'] as String,
      nickName: json['nickName'] as String,
      isEmailVerified: json['isEmailVerified'] as bool,
      verificationCodeSent: json['verificationCodeSent'] as bool,
    );

Map<String, dynamic> _$RegisterResultToJson(RegisterResult instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'nickName': instance.nickName,
      'isEmailVerified': instance.isEmailVerified,
      'verificationCodeSent': instance.verificationCodeSent,
    };
