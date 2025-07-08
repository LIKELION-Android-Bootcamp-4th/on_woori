// 파일 경로: lib/data/responses/product_register_response.dart

import 'package:json_annotation/json_annotation.dart';

part 'product_register_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductRegisterResponse {
  final bool success;
  final String message;
  final ProductCreationData? data;
  final DateTime? timestamp;

  const ProductRegisterResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory ProductRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRegisterResponseToJson(this);
}

@JsonSerializable()
class ProductCreationData {
  final String id;
  final String name;

  const ProductCreationData({
    required this.id,
    required this.name,
  });

  factory ProductCreationData.fromJson(Map<String, dynamic> json) =>
      _$ProductCreationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCreationDataToJson(this);
}