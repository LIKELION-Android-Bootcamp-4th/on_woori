// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailResponse _$VerifyEmailResponseFromJson(Map<String, dynamic> json) =>
    VerifyEmailResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      result: VerifyResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyEmailResponseToJson(
  VerifyEmailResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'result': instance.result.toJson(),
};

VerifyResult _$VerifyResultFromJson(Map<String, dynamic> json) => VerifyResult(
  userId: json['userId'] as String,
  isEmailVerified: json['isEmailVerified'] as bool,
);

Map<String, dynamic> _$VerifyResultToJson(VerifyResult instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isEmailVerified': instance.isEmailVerified,
    };
