import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_response.dart';

part 'mypage_request.g.dart';

@JsonSerializable(explicitToJson: true)
class BuyerProfileEditRequest {
  final String nickName;
  final String? profileImage;
  final String? phone;
  final AddressData? address;

  const BuyerProfileEditRequest({
    required this.nickName,
    required this.profileImage,
    required this.phone,
    required this.address
  });

  factory BuyerProfileEditRequest.fromJson(Map<String, dynamic> json) =>
      _$BuyerProfileEditRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerProfileEditRequestToJson(this);
}