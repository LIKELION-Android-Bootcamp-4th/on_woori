import 'package:json_annotation/json_annotation.dart';

part 'cart_checkout_request.g.dart';

@JsonSerializable()
class CartCheckoutRequest {
  final List<String> cartIds;

  const CartCheckoutRequest({required this.cartIds});

  factory CartCheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CartCheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartCheckoutRequestToJson(this);
}
