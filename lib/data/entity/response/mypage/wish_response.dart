import 'package:json_annotation/json_annotation.dart';

part 'wish_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WishResponse {
  final WishData data;
  final bool success;
  final String message;
  final DateTime timestamp;

  const WishResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory WishResponse.fromJson(Map<String, dynamic> json) =>
      _$WishResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WishResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WishData {
  final List<WishlistItem> items;

  const WishData({
    required this.items,
  });

  factory WishData.fromJson(Map<String, dynamic> json) =>
      _$WishDataFromJson(json);

  Map<String, dynamic> toJson() => _$WishDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WishlistItem {
  final Product productId;
  final Store store;

  WishlistItem({
    required this.productId,
    required this.store,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistItemToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int price;
  final int discountRate;
  final String imageUrl;
  final int stockQuantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountRate,
    required this.imageUrl,
    required this.stockQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Store {
  final String name;

  Store({required this.name});

  factory Store.fromJson(Map<String, dynamic> json) =>
      _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}