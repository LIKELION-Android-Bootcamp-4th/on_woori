// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) =>
    VerifyEmailRequest(
      email: json['email'] as String?,
      verificationCode: json['verificationCode'] as String?,
    );

Map<String, dynamic> _$VerifyEmailRequestToJson(VerifyEmailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verificationCode': instance.verificationCode,
    };
