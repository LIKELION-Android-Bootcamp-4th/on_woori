import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

ProductImages? _productImagesFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) return ProductImages.fromJson(json);
  if (json is String) {
    if (json.isEmpty) return null;
    return ProductImages.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
  return null;
}

int? _discountFromJson(dynamic json) {
  if (json == null) return null;
  if (json is int) return json;
  if (json is String) {
    if (json.isEmpty) return null;
    final decoded = jsonDecode(json) as Map<String, dynamic>;
    return decoded['value'] as int?;
  }
  return null;
}


@JsonSerializable(explicitToJson: true)
class ProductsResponse {
  final bool success;
  final String message;
  final ProductsData? data;
  final DateTime? timestamp;

  const ProductsResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductsData {
  final List<ProductItem>? items;
  const ProductsData({this.items});

  factory ProductsData.fromJson(Map<String, dynamic> json) =>
      _$ProductsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductItem {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int price;
  final bool isFavorite;
  final int? stock;
  final String? stockType;

  @JsonKey(fromJson: _discountFromJson)
  final int? discount;

  final String? status;
  @JsonKey(fromJson: _productImagesFromJson)
  final ProductImages? images;
  final StoreData? store;

  const ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.isFavorite,
    this.stock,
    this.stockType,
    this.discount,
    this.status,
    this.images,
    this.store,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}

@JsonSerializable()
class ProductImages {
  final String main;
  final List<String>? detail;

  const ProductImages({required this.main, this.detail});

  factory ProductImages.fromJson(Map<String, dynamic> json) =>
      _$ProductImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImagesToJson(this);
}

@JsonSerializable()
class ProductOptions {
  final List<String>? color;
  final List<String>? size;

  const ProductOptions({this.color, this.size});

  factory ProductOptions.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionsToJson(this);
}

@JsonSerializable()
class StoreData {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  final String name;
  final String? owner;
  final String? companyId;

  const StoreData({
    this.id,
    required this.name,
    this.owner,
    this.companyId,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) =>
      _$StoreDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDataToJson(this);
}