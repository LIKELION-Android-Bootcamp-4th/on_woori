import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

part 'wish_response.g.dart';

Images? _wishImagesFromJson(String? jsonString) {
  if (jsonString == null || jsonString.isEmpty) return null;
  try {
    final decoded = jsonDecode(jsonString);
    return Images.fromJson(decoded as Map<String, dynamic>);
  } catch (e) {
    return null;
  }
}

@JsonSerializable(explicitToJson: true)
class WishResponse {
  final bool success;
  final String message;
  final WishData? data;
  final DateTime? timestamp;

  const WishResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory WishResponse.fromJson(Map<String, dynamic> json) =>
      _$WishResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WishResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WishData {
  final List<WishItem>? items;
  final PaginationData? pagination;

  const WishData({this.items, this.pagination});

  factory WishData.fromJson(Map<String, dynamic> json) =>
      _$WishDataFromJson(json);
  Map<String, dynamic> toJson() => _$WishDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WishItem {
  final String id;
  final String entityType;
  final String entityId;
  final WishProductEntity? entity;
  final DateTime? createdAt;

  final StoreData? store;


  const WishItem({
    required this.id,
    required this.entityType,
    required this.entityId,
    this.entity,
    this.createdAt,
    this.store,
  });

  factory WishItem.fromJson(Map<String, dynamic> json) =>
      _$WishItemFromJson(json);
  Map<String, dynamic> toJson() => _$WishItemToJson(this);
}

@JsonSerializable()
class WishProductEntity {
  final String id;
  final String name;
  final int price;

  @JsonKey(fromJson: _wishImagesFromJson)
  final Images? images;

  const WishProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.images,
  });

  factory WishProductEntity.fromJson(Map<String, dynamic> json) =>
      _$WishProductEntityFromJson(json);
  Map<String, dynamic> toJson() => _$WishProductEntityToJson(this);
}

@JsonSerializable()
class PaginationData {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPrevPage;

  const PaginationData({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) =>
      _$PaginationDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationDataToJson(this);
}