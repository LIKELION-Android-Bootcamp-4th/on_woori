import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

Images? _imagesFromJson(String? jsonString) {
  if (jsonString == null || jsonString.isEmpty) return null;
  try {
    final decoded = jsonDecode(jsonString);
    return Images.fromJson(decoded as Map<String, dynamic>);
  } catch (e) {
    return null;
  }
}

String? _discountToStringJson(dynamic json) {
  if (json == null || (json is String && json.isEmpty)) return null;
  if (json is num) return json.toString();
  if (json is String) return json;
  if (json is Map) return jsonEncode(json);
  return json.toString();
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
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final int price;
  final bool isFavorite;
  final int? stock;
  final String? stockType;
  @JsonKey(fromJson: _discountToStringJson)
  final String? discount;
  final String? status;
  final StoreData? store;
  final ThumbnailImage? thumbnailImage;

  @JsonKey(fromJson: _imagesFromJson)
  final Images? images;

  const ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.isFavorite,
    this.stock,
    this.stockType,
    this.discount,
    this.status,
    this.store,
    this.thumbnailImage,
    this.images,
    // this.options,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}

@JsonSerializable()
class ThumbnailImage {
  final String id;
  final String url;

  const ThumbnailImage({required this.id, required this.url});

  factory ThumbnailImage.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailImageFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailImageToJson(this);
}

@JsonSerializable()
class Images {
  final List<String>? detail;

  const Images({this.detail});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
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