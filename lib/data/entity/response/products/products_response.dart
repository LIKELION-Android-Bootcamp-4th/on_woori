import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsResponse {
  final bool success;
  final String message;
  final ProductsData data;
  final DateTime timestamp;

  const ProductsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductsData {
  final List<ProductItem> items;
  const ProductsData({required this.items});

  factory ProductsData.fromJson(Map<String, dynamic> json) =>
      _$ProductsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductItem {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final int price;
  final String stockType;
  final int stock;
  final ProductImages images;
  final ProductOptions options;
  final int? discount;
  final String status;
  final StoreData? store;
  final bool isFavorite;
  final String? storeOwnerId;

  const ProductItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockType,
    required this.stock,
    required this.images,
    required this.options,
    this.discount,
    required this.status,
    this.store,
    required this.isFavorite,
    this.storeOwnerId,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}

@JsonSerializable()
class ProductImages {
  final String main;
  final List<String>? sub;
  final List<String>? detail;
  const ProductImages({required this.main, this.sub, this.detail});
  factory ProductImages.fromJson(Map<String, dynamic> json) =>
      _$ProductImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImagesToJson(this);
}

@JsonSerializable()
class ProductOptions {
  final List<String> color;
  const ProductOptions({required this.color});
  factory ProductOptions.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionsToJson(this);
}

@JsonSerializable()
class StoreData {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  final String name;
  final String owner;
  final String companyId;
  final String? status;

  const StoreData({
    this.id,
    required this.name,
    required this.owner,
    required this.companyId,
    this.status,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) =>
      _$StoreDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDataToJson(this);
}