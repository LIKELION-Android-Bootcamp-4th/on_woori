import 'package:json_annotation/json_annotation.dart';

part 'seller_store_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SellerStoreResponse {
  final bool success;
  final String message;
  final StoreData? data;
  final String? timestamp;

  SellerStoreResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory SellerStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$SellerStoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SellerStoreResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StoreData {
  final String? id;
  final String? name;
  final String? description;
  final OwnerData? owner;

  final String? companyId;
  final ShippingPolicy? shippingPolicy;
  final String? status;
  final bool? isDeleted;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final dynamic thumbnailImage;
  final String? thumbnailImageUrl;
  final dynamic coverImage;
  final String? coverImageUrl;
  final dynamic bannerImage;
  final String? bannerImageUrl;

  StoreData({
    this.id,
    this.name,
    this.description,
    this.owner,
    this.companyId,
    this.shippingPolicy,
    this.status,
    this.isDeleted,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.thumbnailImage,
    this.thumbnailImageUrl,
    this.coverImage,
    this.coverImageUrl,
    this.bannerImage,
    this.bannerImageUrl,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) =>
      _$StoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OwnerData {
  final String? id;
  final String? email;
  final String? nickName;
  final Profile? profile;
  final List<String>? loginRoles;
  final List<String>? platformRoles;
  final bool? isActive;
  final bool? needEmailVerification;
  final bool? emailVerified;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OwnerData({
    this.id,
    this.email,
    this.nickName,
    this.profile,
    this.loginRoles,
    this.platformRoles,
    this.isActive,
    this.needEmailVerification,
    this.emailVerified,
    this.companyId,
    this.createdAt,
    this.updatedAt,
  });

  factory OwnerData.fromJson(Map<String, dynamic> json) =>
      _$OwnerDataFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerDataToJson(this);
}

@JsonSerializable()
class Profile {
  final String? name;
  final String? profileImage;
  final String? birthDate;

  Profile({this.name, this.profileImage, this.birthDate});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class ShippingPolicy {
  final int? defaultShippingCost;
  final int? freeShippingThreshold;
  final bool? freeShippingEnabled;

  ShippingPolicy({
    this.defaultShippingCost,
    this.freeShippingThreshold,
    this.freeShippingEnabled,
  });

  factory ShippingPolicy.fromJson(Map<String, dynamic> json) =>
      _$ShippingPolicyFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingPolicyToJson(this);
}
