import 'package:json_annotation/json_annotation.dart';

part 'cart_request.g.dart';

@JsonSerializable()
class CartRequest {
  final List<String> cartIds;

  const CartRequest({required this.cartIds});

  factory CartRequest.fromJson(Map<String, dynamic> json) =>
      _$CartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartRequestToJson(this);
}
