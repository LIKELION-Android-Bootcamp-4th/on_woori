import 'package:json_annotation/json_annotation.dart';

part 'orders_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrdersResponse {
  final bool success;
  final String message;
  final OrdersData data;
  final DateTime timestamp;

  const OrdersResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrdersData {
  @JsonKey(name: 'items')
  final List<OrderItem> orders;
  final PaginationData pagination;

  const OrdersData({required this.orders, required this.pagination});

  factory OrdersData.fromJson(Map<String, dynamic> json) =>
      _$OrdersDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItem {
  @JsonKey(name: 'id')
  final String id;
  final String orderNumber;
  final int totalAmount;
  final String status;
  final DateTime createdAt;

  @JsonKey(name: 'items')
  final List<OrderedProductItem> products;

  const OrderItem({
    required this.id,
    required this.orderNumber,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.products,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderedProductItem {
  //final ProductId productId;
  final String id;
  final String productName;
  final int quantity;

  const OrderedProductItem({
    required this.id,
    required this.productName,
    required this.quantity,
  });

  factory OrderedProductItem.fromJson(Map<String, dynamic> json) =>
      _$OrderedProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderedProductItemToJson(this);
}

@JsonSerializable()
class ProductId {
  final String id;
  final String name;

  const ProductId({required this.id, required this.name});

  factory ProductId.fromJson(Map<String, dynamic> json) =>
      _$ProductIdFromJson(json);

  Map<String, dynamic> toJson() => _$ProductIdToJson(this);
}

@JsonSerializable()
class PaginationData {
  final int currentPage;
  final int totalPages;
  final int total;
  final bool hasNext;
  final bool hasPrev;

  const PaginationData({
    required this.currentPage,
    required this.totalPages,
    required this.total,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) =>
      _$PaginationDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDataToJson(this);
}
