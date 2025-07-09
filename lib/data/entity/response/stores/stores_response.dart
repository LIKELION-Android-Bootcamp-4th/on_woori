import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

part 'stores_response.g.dart';

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