import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

Images? _imagesFromJson(String? jsonString) {
  if (jsonString == null || jsonString.isEmpty) return null;
  try {
    final decoded = jsonDecode(jsonString);
    return Images.fromJson(decoded as Map<String, dynamic>);
  } catch (e) {
    debugPrint('Images parsing error for string "$jsonString": $e');
    return null;
  }
}

// 서버에서 어떤 형식의 'options'를 보내든 처리할 수 있도록 수정된 함수
List<ProductOptionGroup>? _optionsListFromJson(dynamic json) {
  if (json == null) {
    return null;
  }

  // 1. 서버가 JSON 객체를 직접 보낼 경우 (가장 최신 형식)
  if (json is Map<String, dynamic>) {
    final Map<String, dynamic> optionsMap = json;
    final List<ProductOptionGroup> options = [];

    // 'size' 옵션 처리
    if (optionsMap.containsKey('size') && optionsMap['size'] is List) {
      options.add(ProductOptionGroup(
        type: 'size',
        name: '사이즈',
        items: List<String>.from(optionsMap['size'])
            .map((s) => ProductOptionItem(code: s))
            .toList(),
      ));
    }

    // 'color' 옵션 처리 (문자열 또는 리스트 모두 대응)
    if (optionsMap.containsKey('color')) {
      final dynamic colorValue = optionsMap['color'];
      List<String> colorItems = [];
      if (colorValue is String) {
        colorItems.add(colorValue);
      } else if (colorValue is List) {
        colorItems = List<String>.from(colorValue);
      }

      if (colorItems.isNotEmpty) {
        options.add(ProductOptionGroup(
          type: 'color',
          name: '컬러',
          items: colorItems.map((c) => ProductOptionItem(code: c)).toList(),
        ));
      }
    }
    return options.isNotEmpty ? options : null;
  }

  // 2. 서버가 JSON 문자열을 보낼 경우 (이전 형식 - 폴백)
  if (json is String && json.isNotEmpty) {
    try {
      final decoded = jsonDecode(json);
      // 재귀적으로 함수를 다시 호출하여 처리
      return _optionsListFromJson(decoded);
    } catch (e) {
      debugPrint('Options string parsing error: $e');
      return null;
    }
  }

  return null;
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
  final String description;
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

  // 수정된 파싱 함수를 적용합니다.
  @JsonKey(fromJson: _optionsListFromJson)
  final List<ProductOptionGroup>? options;

  const ProductItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isFavorite,
    this.stock,
    this.stockType,
    this.discount,
    this.status,
    this.store,
    this.thumbnailImage,
    this.images,
    this.options,
    this.category,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}

@JsonSerializable()
class ThumbnailImage {
  final String? id;
  final String? url;

  const ThumbnailImage({this.id, this.url});

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
    this.thumbnailImageUrl,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) =>
      _$StoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDataToJson(this);
}
