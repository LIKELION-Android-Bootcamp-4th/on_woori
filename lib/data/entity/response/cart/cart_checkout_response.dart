import 'package:json_annotation/json_annotation.dart';

part 'cart_checkout_response.g.dart';

@JsonSerializable()
class CartCheckoutResponse {
  final bool success;
  final String message;
  final DateTime? timestamp;

  const CartCheckoutResponse({
    required this.success,
    required this.message,
    this.timestamp,
  });

  factory CartCheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CartCheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartCheckoutResponseToJson(this);
}