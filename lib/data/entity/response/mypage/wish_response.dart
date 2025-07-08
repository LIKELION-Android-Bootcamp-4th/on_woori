import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'wish_response.g.dart';


/// 'images' 필드(문자열화된 JSON)를 파싱하기 위한 함수
Images? _imagesFromJson(String? jsonString) {
  if (jsonString == null || jsonString.isEmpty) return null;
  try {
    final decoded = jsonDecode(jsonString);
    return Images.fromJson(decoded as Map<String, dynamic>);
  } catch (e) {
    return null;
  }
}

/// 'discount' 필드를 안전하게 String? 타입으로 변환하는 함수
String? _discountToStringJson(dynamic json) {
  if (json == null || (json is String && json.isEmpty)) return null;
  if (json is num) return json.toString();
  if (json is String) return json;
  if (json is Map) return jsonEncode(json);
  return json.toString();
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
  final List<WishlistItem>? items;

  const WishData({
    this.items,
  });

  factory WishData.fromJson(Map<String, dynamic> json) =>
      _$WishDataFromJson(json);

  Map<String, dynamic> toJson() => _$WishDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WishlistItem {
  @JsonKey(name: 'productId')
  final Product? product;
  final Store? store;

  const WishlistItem({
    this.product,
    this.store,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Product {
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

  final ThumbnailImage? thumbnailImage;
  @JsonKey(fromJson: _imagesFromJson)
  final Images? images;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.isFavorite,
    this.stock,
    this.stockType,
    this.discount,
    this.status,
    this.thumbnailImage,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
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
class Store {
  final String name;

  const Store({required this.name});

  factory Store.fromJson(Map<String, dynamic> json) =>
      _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}