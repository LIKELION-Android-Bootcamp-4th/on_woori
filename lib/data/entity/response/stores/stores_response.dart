import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

part 'stores_response.g.dart';

@JsonSerializable(explicitToJson: true)
class StoresResponse {
  final bool success;
  final String message;
  final StoresData? data;
  final DateTime? timestamp;

  StoresResponse({
    required this.success,
    required this.message,
    this.data,
    required this.timestamp,
  });

  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

// 🚀 [추가] data 객체를 위한 StoresData 클래스
@JsonSerializable(explicitToJson: true)
class StoresData {
  final List<StoreItem> items;
  final String? pagination;

  const StoresData({
    required this.items,
    this.pagination,
  });

  factory StoresData.fromJson(Map<String, dynamic> json) =>
      _$StoresDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoresDataToJson(this);
}


@JsonSerializable(explicitToJson: true)
class StoreItem {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String? description;
  final String owner;
  final String companyId;
  final String status;
  final bool isDeleted;
  final String? category;
  final ShippingPolicy? shippingPolicy;
  final Contact? contact;
  final Address? address;
  final String? thumbnailImageUrl;
  final String? coverImageUrl;
  final String? bannerImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  StoreItem({
    required this.id,
    required this.name,
    this.description,
    required this.owner,
    required this.companyId,
    required this.status,
    required this.isDeleted,
    this.category,
    this.shippingPolicy,
    this.contact,
    this.address,
    this.thumbnailImageUrl,
    this.coverImageUrl,
    this.bannerImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreItem.fromJson(Map<String, dynamic> json) =>
      _$StoreItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoreItemToJson(this);
}

@JsonSerializable()
class ShippingPolicy {
  final int? defaultShippingCost;
  final int? freeShippingThreshold;
  final bool? freeShippingEnabled;

  const ShippingPolicy({
    this.defaultShippingCost,
    this.freeShippingThreshold,
    this.freeShippingEnabled,
  });

  factory ShippingPolicy.fromJson(Map<String, dynamic> json) =>
      _$ShippingPolicyFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingPolicyToJson(this);
}

@JsonSerializable()
class Contact {
  final String? kakaoTalk;
  final String? phone;
  final String? email;
  final String? website;

  const Contact({this.kakaoTalk, this.phone, this.email, this.website});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

@JsonSerializable()
class Address {
  final String? street;
  final String? detail;
  final String? zipCode;

  const Address({this.street, this.detail, this.zipCode});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}


// --- 아래 클래스들은 기존 파일에 있었으므로 그대로 유지 ---

@JsonSerializable()
class StoreOwner {
  @JsonKey(name: 'id')
  final String id;
  final String nickName;
  final StoreOwnerProfile profile;

  StoreOwner({
    required this.id,
    required this.nickName,
    required this.profile
  });

  factory StoreOwner.fromJson(Map<String, dynamic> json) =>
      _$StoreOwnerFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOwnerToJson(this);
}

@JsonSerializable()
class StoreDetailResponse {
  final bool success;
  final String message;
  final StoreDetailItem data;
  final DateTime timestamp;

  StoreDetailResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDetailResponseToJson(this);
}

@JsonSerializable()
class StoreDetailItem {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final StoreOwner owner;
  final String description;

  StoreDetailItem({
    required this.id,
    required this.name,
    required this.owner,
    required this.description,
  });

  factory StoreDetailItem.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDetailItemToJson(this);
}

@JsonSerializable()
class StoreOwnerProfile {
  final String name;
  final String profileImage;

  StoreOwnerProfile({
    required this.name,
    required this.profileImage
  });

  factory StoreOwnerProfile.fromJson(Map<String, dynamic> json) =>
      _$StoreOwnerProfileFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOwnerProfileToJson(this);
}

@JsonSerializable()
class StoreProductsResponse {
  final bool success;
  final String message;
  final List<ProductItem> data;
  final DateTime timestamp;

  StoreProductsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory StoreProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreProductsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreProductsResponseToJson(this);
}