import 'package:json_annotation/json_annotation.dart';

part 'cart_response.g.dart';

Map<String, String>? _optionsFromJson(dynamic json) {
  if (json == null || json is! Map<String, dynamic>) {
    return null;
  }
  return json.map((key, value) => MapEntry(key.toString(), value.toString()));
}

ThumbnailImage? _thumbnailImageFromJson(dynamic json) {
  if (json == null || json is! Map<String, dynamic>) {
    return null;
  }
  final urlValue = json['url'];
  final String? finalUrl = urlValue is String ? urlValue : null;

  final idValue = json['id'];
  final String? finalId = idValue is String ? idValue : null;

  return ThumbnailImage(id: finalId, url: finalUrl);
}

@JsonSerializable(explicitToJson: true)
class CartResponse {
  final bool success;
  final String message;
  final CartData? data;
  final DateTime? timestamp;

  int get grandTotal {
    return data?.items?.fold(0, (sum, item) => sum! + item.totalPrice) ?? 0;
  }

  const CartResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartData {
  final List<CartItem>? items;
  final CartPagination? pagination;

  const CartData({this.items, this.pagination});

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartItem {
  final String id;
  final CartProduct product;
  final int quantity;
  final int cartPrice;
  final int totalPrice;
  final String storeId;
  final String storeName;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.cartPrice,
    required this.totalPrice,
    required this.storeId,
    required this.storeName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class CartProduct {
  final String id;
  final String name;
  final int unitPrice;

  // *** MODIFIED ***
  // 새로 추가한 안전 파싱 함수를 적용합니다.
  @JsonKey(fromJson: _thumbnailImageFromJson)
  final ThumbnailImage? thumbnailImage;

  @JsonKey(fromJson: _optionsFromJson)
  final Map<String, String>? options;

  String get optionText {
    if (options == null || options!.isEmpty) {
      return '옵션 없음';
    }
    return options!.entries
        .map((e) => '${e.key}: ${e.value}')
        .join(' / ');
  }

  const CartProduct({
    required this.id,
    required this.name,
    required this.unitPrice,
    this.thumbnailImage,
    this.options,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}

@JsonSerializable()
class ThumbnailImage {
  final String? id;
  final String? url;

  const ThumbnailImage({
    this.id,
    this.url,
  });

  factory ThumbnailImage.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailImageFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailImageToJson(this);
}

@JsonSerializable()
class CartPagination {
  final int currentPage;
  final int totalPages;
  final int total;
  final int limit;
  final bool hasNext;
  final bool hasPrev;

  const CartPagination({
    required this.currentPage,
    required this.totalPages,
    required this.total,
    required this.limit,
    required this.hasNext,
    required this.hasPrev,
  });

  factory CartPagination.fromJson(Map<String, dynamic> json) =>
      _$CartPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$CartPaginationToJson(this);
}
