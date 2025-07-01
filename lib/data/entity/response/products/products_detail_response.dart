import 'package:json_annotation/json_annotation.dart';

import 'package:on_woori/data/entity/response/products/products_response.dart';

part 'products_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsDetailResponse {
  final bool success;
  final String message;
  final ProductsDetailData data;
  final DateTime timestamp;

  const ProductsDetailResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory ProductsDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductsDetailData {
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

  const ProductsDetailData({
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
  });

  factory ProductsDetailData.fromJson(Map<String, dynamic> json) =>
      _$ProductsDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsDetailDataToJson(this);
}