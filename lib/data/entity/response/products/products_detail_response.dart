import 'package:json_annotation/json_annotation.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

part 'products_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsDetailResponse {
  final bool success;
  final String message;
  final ProductItem? data;
  final DateTime? timestamp;

  const ProductsDetailResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory ProductsDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsDetailResponseToJson(this);
}