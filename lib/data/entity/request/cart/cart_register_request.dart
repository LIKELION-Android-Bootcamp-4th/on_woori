import 'package:json_annotation/json_annotation.dart';

part 'cart_register_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CartRegisterRequest {
  final String productId;
  final int quantity;
  final int unitPrice;
  // final CartOptions options;

  @JsonKey(includeIfNull: false)
  final CartDiscount? discount;

  const CartRegisterRequest({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    // this.options,
    this.discount,
  });

  factory CartRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$CartRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartRegisterRequestToJson(this);
}

@JsonSerializable()
class CartOptions {
  @JsonKey(includeIfNull: false)
  final String? size;

  @JsonKey(includeIfNull: false)
  final String? color;

  const CartOptions({
    this.size,
    this.color,
  });

  factory CartOptions.fromJson(Map<String, dynamic> json) =>
      _$CartOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$CartOptionsToJson(this);
}

@JsonSerializable()
class CartDiscount {
  final String type;
  final int amount;

  const CartDiscount({
    required this.type,
    required this.amount,
  });

  factory CartDiscount.fromJson(Map<String, dynamic> json) =>
      _$CartDiscountFromJson(json);

  Map<String, dynamic> toJson() => _$CartDiscountToJson(this);
}