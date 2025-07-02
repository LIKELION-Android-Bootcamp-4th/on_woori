import 'package:json_annotation/json_annotation.dart';

part 'mypage_profile_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MyPageProfileResponse {
  final String success;
  final String message;
  final MyPageData data;
  final DateTime timestamp;

  const MyPageProfileResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory MyPageProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$MyPageProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageProfileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyPageData {
  @JsonKey(name: '_id')
  final String id;
  final String email;
  final String nickName;
  final bool isAdmin;
  final bool isSuperAdmin;
  final bool isActive;

  const MyPageData({
    required this.id,
    required this.email,
    required this.nickName,
    required this.isAdmin,
    required this.isSuperAdmin,
    required this.isActive,
  });

  factory MyPageData.fromJson(Map<String, dynamic> json) =>
      _$MyPageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageDataToJson(this);
}
