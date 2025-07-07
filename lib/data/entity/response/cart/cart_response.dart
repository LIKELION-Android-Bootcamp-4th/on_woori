import 'package:json_annotation/json_annotation.dart';

part 'cart_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CartResponse {
  final CartData? data;

  int get grandTotal {
    return data?.items?.fold(0, (sum, item) => sum! + item.totalPrice) ?? 0;
  }

  const CartResponse({this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartData {
  final List<CartItem>? items;

  const CartData({this.items});

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);
  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartItem {
  final CartProduct product;
  final int quantity; // 수량
  final int cartPrice; // 할인이 적용된 개당 가격
  final int totalPrice; // 수량 * 개당 가격

  const CartItem({
    required this.product,
    required this.quantity,
    required this.cartPrice,
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class CartProduct {
  final String name;
  final String? thumbnailImage;
  final Map<String, String>? options;

  String get optionText {
    if (options == null || options!.isEmpty) {
      return '선택된 옵션 없음';
    }
    return options!.entries.map((e) => '${e.key}: ${e.value}').join(' / ');
  }

  const CartProduct({
    required this.name,
    this.thumbnailImage,
    this.options,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}