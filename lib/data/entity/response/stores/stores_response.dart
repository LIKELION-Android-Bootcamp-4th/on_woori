import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

part 'stores_response.g.dart';

@JsonSerializable()
class StoresResponse {
  final bool success;
  final String message;
  final List<StoreItem> data;
  final DateTime timestamp;

  StoresResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

@JsonSerializable()
class StoreItem {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String? description;
  final String owner;

  StoreItem({
    required this.id,
    required this.name,
    this.description,
    required this.owner,
  });

  factory StoreItem.fromJson(Map<String, dynamic> json) =>
      _$StoreItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoreItemToJson(this);
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