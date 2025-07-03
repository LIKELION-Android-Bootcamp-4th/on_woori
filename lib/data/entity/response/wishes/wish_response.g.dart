// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishResponse _$WishResponseFromJson(Map<String, dynamic> json) => WishResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: WishData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WishResponseToJson(WishResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data.toJson(),
    };

WishData _$WishDataFromJson(Map<String, dynamic> json) => WishData(
  id: json['_id'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => WishlistItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WishDataToJson(WishData instance) => <String, dynamic>{
  '_id': instance.id,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'pagination': instance.pagination.toJson(),
};

WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) => WishlistItem(
  id: json['_id'] as String,
  productId: Product.fromJson(json['productId'] as Map<String, dynamic>),
  likedAt: json['likedAt'] as String,
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  store: Store.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WishlistItemToJson(WishlistItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'likedAt': instance.likedAt,
      'category': instance.category,
      'store': instance.store,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  discountPrice: (json['discountPrice'] as num).toInt(),
  discountRate: (json['discountRate'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
  isInStock: json['isInStock'] as bool,
  stockQuantity: (json['stockQuantity'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'discountPrice': instance.discountPrice,
  'discountRate': instance.discountRate,
  'imageUrl': instance.imageUrl,
  'isInStock': instance.isInStock,
  'stockQuantity': instance.stockQuantity,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
};

Category _$CategoryFromJson(Map<String, dynamic> json) =>
    Category(name: json['name'] as String);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'name': instance.name,
};

Store _$StoreFromJson(Map<String, dynamic> json) =>
    Store(name: json['name'] as String);

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'name': instance.name,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalItems: (json['totalItems'] as num).toInt(),
  itemsPerPage: (json['itemsPerPage'] as num).toInt(),
  hasNext: json['hasNext'] as bool,
  hasPrev: json['hasPrev'] as bool,
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'itemsPerPage': instance.itemsPerPage,
      'hasNext': instance.hasNext,
      'hasPrev': instance.hasPrev,
    };
