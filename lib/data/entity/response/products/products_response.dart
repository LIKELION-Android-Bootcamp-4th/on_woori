import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

List<ProductOptionGroup>? _optionsListFromJson(String? jsonString) {
  if (jsonString == null || jsonString.isEmpty) {
    return null;
  }
  try {
    final List<dynamic> decodedList = jsonDecode(jsonString);
    return decodedList
        .map((item) => ProductOptionGroup.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('Options parsing error for string "$jsonString": $e');
    return null;
  }
}

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
  final bool? isFavorite;
  final int? stock;
  final String? stockType;
  @JsonKey(fromJson: _discountToStringJson)
  final String? discount;
  final String? status;
  final StoreData? store;
  final ThumbnailImage? thumbnailImage;
  final String? category;

  @JsonKey(fromJson: _imagesFromJson)
  final Images? images;

  @JsonKey(fromJson: _optionsListFromJson)
  final List<ProductOptionGroup>? options;

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
    this.options,
    this.category
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

@JsonSerializable(explicitToJson: true)
class ProductOptionGroup {
  final String type;
  final String name;
  final List<ProductOptionItem> items;

  const ProductOptionGroup({
    required this.type,
    required this.name,
    required this.items,
  });

  factory ProductOptionGroup.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionGroupToJson(this);
}

@JsonSerializable()
class ProductOptionItem {
  final String code;

  const ProductOptionItem({required this.code});

  factory ProductOptionItem.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionItemToJson(this);
}

@JsonSerializable()
class StoreData {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  final String name;
  final String? owner;
  final String? companyId;
  final String? thumbnailImageUrl;

  const StoreData({
    this.id,
    required this.name,
    this.owner,
    this.companyId,
    this.thumbnailImageUrl
  });

  factory StoreData.fromJson(Map<String, dynamic> json) =>
      _$StoreDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDataToJson(this);
}