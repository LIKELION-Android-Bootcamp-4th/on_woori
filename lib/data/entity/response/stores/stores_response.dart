import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_response.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

part 'stores_response.g.dart';

// Helper 함수들은 그대로 유지합니다.
Contact? _contactFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return Contact.fromJson(json);
  }
  return null;
}

Address? _addressFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return Address.fromJson(json);
  }
  return null;
}

ThumbnailImage? _thumbnailImageFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return ThumbnailImage.fromJson(json);
  }
  return null;
}

Pagination? _paginationFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return Pagination.fromJson(json);
  }
  return null;
}

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
    this.timestamp,
  });

  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StoresData {
  final List<StoreItem> items;
  @JsonKey(fromJson: _paginationFromJson)
  final Pagination? pagination;

  const StoresData({
    required this.items,
    this.pagination,
  });

  factory StoresData.fromJson(Map<String, dynamic> json) =>
      _$StoresDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoresDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User {
  final String companyId;
  final String createdAt;
  final String id;

  User({
    required this.companyId,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StoreItem {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String? description;

  @JsonKey(fromJson: User.fromJson)
  final User owner;

  final String companyId;
  final String status;
  final bool isDeleted;
  final String? category;
  final ShippingPolicy? shippingPolicy;

  @JsonKey(fromJson: _contactFromJson)
  final Contact? contact;

  @JsonKey(fromJson: _addressFromJson)
  final Address? address;

  @JsonKey(fromJson: _thumbnailImageFromJson)
  final ThumbnailImage? thumbnailImage;

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
    this.thumbnailImage,
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

@JsonSerializable()
class Pagination {
  final int currentPage;
  final int totalPages;
  @JsonKey(name: 'total')
  final int totalItems;
  @JsonKey(name: 'limit')
  final int itemsPerPage;
  @JsonKey(name: 'hasNext')
  final bool hasNextPage;
  @JsonKey(name: 'hasPrev')
  final bool hasPrevPage;

  const Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

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
  final String? thumbnailImageUrl;

  StoreDetailItem({
    required this.id,
    required this.name,
    required this.owner,
    required this.description,
    this.thumbnailImageUrl
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

// --- 수정된 부분 START ---

@JsonSerializable(explicitToJson: true)
class StoreProductsResponse {
  final bool success;
  final String message;
  final StoreProductsData? data;
  final DateTime? timestamp;

  StoreProductsResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory StoreProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreProductsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreProductsResponseToJson(this);
}

// [추가] JSON의 data 객체 구조를 담을 새로운 클래스
@JsonSerializable(explicitToJson: true)
class StoreProductsData {
  final List<ProductItem> items;
  final Pagination? pagination;

  const StoreProductsData({
    required this.items,
    this.pagination,
  });

  factory StoreProductsData.fromJson(Map<String, dynamic> json) =>
      _$StoreProductsDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoreProductsDataToJson(this);
}

// seller 조회 관련
@JsonSerializable(explicitToJson: true)
class SellerStoreResponse {
  final bool success;
  final String message;
  final SellerStoreData data;

  const SellerStoreResponse({
    required this.success,
    required this.message,
    required this.data
  });

  factory SellerStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$SellerStoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SellerStoreResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SellerStoreData {
  final String name;
  final String? description;
  final String? thumbnailImageUrl; //여기가 브랜드 아이콘
  //이하 사용하지 않는 데이터도 필드 유지를 위해 받아옵니다
  final String id;
  final String? category;
  final String? status;

  const SellerStoreData({
    required this.name,
    this.description,
    this.thumbnailImageUrl,
    required this.id,
    this.category,
    this.status,
  });

  factory SellerStoreData.fromJson(Map<String, dynamic> json) =>
      _$SellerStoreDataFromJson(json);
  Map<String, dynamic> toJson() => _$SellerStoreDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SellerContact {
  final String? phone;
  final String? email;
  final String? kakaoTalk;

  const SellerContact({
    this.phone,
    this.email,
    this.kakaoTalk
  });

  factory SellerContact.fromJson(Map<String, dynamic> json) =>
      _$SellerContactFromJson(json);
  Map<String, dynamic> toJson() => _$SellerContactToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrandProfileImageData {
  final String? id;
  final String? originalName;
  final String? filename;
  final String? mimeType;
  final String? size;
  final String url;

  const BrandProfileImageData({
    this.id,
    this.originalName,
    this.filename,
    this.mimeType,
    this.size,
    required this.url
  });

  factory BrandProfileImageData.fromJson(Map<String, dynamic> json) =>
      _$BrandProfileImageDataFromJson(json);
  Map<String, dynamic> toJson() => _$BrandProfileImageDataToJson(this);
}
