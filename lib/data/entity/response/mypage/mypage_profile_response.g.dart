// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPageProfileResponse _$MyPageProfileResponseFromJson(
  Map<String, dynamic> json,
) => MyPageProfileResponse(
  success: json['success'] as String,
  message: json['message'] as String,
  data: MyPageData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$MyPageProfileResponseToJson(
  MyPageProfileResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
  'timestamp': instance.timestamp.toIso8601String(),
};

MyPageData _$MyPageDataFromJson(Map<String, dynamic> json) => MyPageData(
  id: json['_id'] as String,
  email: json['email'] as String,
  nickName: json['nickName'] as String,
  isAdmin: json['isAdmin'] as bool,
  isSuperAdmin: json['isSuperAdmin'] as bool,
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$MyPageDataToJson(MyPageData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'nickName': instance.nickName,
      'isAdmin': instance.isAdmin,
      'isSuperAdmin': instance.isSuperAdmin,
      'isActive': instance.isActive,
    };
