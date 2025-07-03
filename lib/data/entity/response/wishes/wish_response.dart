
import 'package:json_annotation/json_annotation.dart';

part 'wish_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WishResponse {
  final bool success;
  final String message;
  final WishData data;

  const WishResponse({
    required this.success,
    required this.message,
    required this.data
  });

  factory WishResponse.fromJson(Map<String, dynamic> json) =>
      _$WishResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WishResponseToJson(this);

}

@JsonSerializable(explicitToJson: true)
class WishData {
  @JsonKey(name: '_id')
  final String id;

  final List<WishlistItem> items;
  final Pagination pagination;

  const WishData({
    required this.id,
    required this.items,
    required this.pagination
  });

  factory WishData.fromJson(Map<String, dynamic> json) =>
      _$WishDataFromJson(json);

  Map<String, dynamic> toJson() => _$WishDataToJson(this);
}

@JsonSerializable()
class WishlistItem {
  @JsonKey(name: '_id')
  final String id;

  final Product productId;
  final String likedAt;
  final Category category;
  final Store store;

  WishlistItem({
    required this.id,
    required this.productId,
    required this.likedAt,
    required this.category,
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
  final int discountPrice;
  final int discountRate;
  final String imageUrl;
  final bool isInStock;
  final int stockQuantity;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.discountRate,
    required this.imageUrl,
    required this.isInStock,
    required this.stockQuantity,
    required this.rating,
    required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}


@JsonSerializable()
class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}


@JsonSerializable()
class Store {
  final String name;

  Store({required this.name});

  factory Store.fromJson(Map<String, dynamic> json) =>
      _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);

}

@JsonSerializable()
class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNext;
  final bool hasPrev;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}