import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail_response.g.dart';

// 🚀 [추가] shippingCostRatio 필드를 안전하게 파싱하기 위한 헬퍼 함수
double? _shippingCostRatioFromJson(dynamic json) {
  if (json is num) {
    return json.toDouble();
  }
  if (json is String) {
    return double.tryParse(json);
  }
  return null;
}

@JsonSerializable(explicitToJson: true)
class OrderDetailResponse {
  final bool success;
  final String message;
  final OrderDetailData? data;
  final DateTime? timestamp;

  const OrderDetailResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$OrderDetailResponseFromJson(json);
    } catch (e, s) {
      debugPrint('Error parsing OrderDetailResponse: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$OrderDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderDetailData {
  @JsonKey(name: 'id')
  final String id;
  final String userId;
  final String companyId;
  final List<OrderItem> items;
  final int totalAmount;
  final int subtotalAmount;
  final int shippingCost;
  final String status;
  final ShippingInfo shippingInfo;
  final String? memo;
  @JsonKey(name: 'createdAt')
  final DateTime orderDate;
  final String orderNumber;
  final List<StatusHistoryItem>? statusHistory;

  const OrderDetailData({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.items,
    required this.totalAmount,
    required this.subtotalAmount,
    required this.shippingCost,
    required this.status,
    required this.shippingInfo,
    this.memo,
    required this.orderDate,
    required this.orderNumber,
    this.statusHistory,
  });

  factory OrderDetailData.fromJson(Map<String, dynamic> json) {
    try {
      return _$OrderDetailDataFromJson(json);
    } catch (e, s) {
      debugPrint('Error parsing OrderDetailData: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$OrderDetailDataToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "id")
  final String productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int totalPrice;
  final String? thumbnailImageUrl;
  final Map<String, dynamic>? options;

  String get optionsText {
    if (options == null || options!.isEmpty) return '옵션 없음';
    return options!.entries.map((e) => '${e.key}: ${e.value}').join(' / ');
  }

  String? get productImage => null;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.thumbnailImageUrl,
    this.options,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    try {
      return _$OrderItemFromJson(json);
    } catch (e, s) {
      debugPrint('Error parsing OrderItem: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class ShippingInfo {
  final String? deliveryOption;
  final bool? freeShippingApplied;

  @JsonKey(fromJson: _shippingCostRatioFromJson)
  final double? shippingCostRatio;

  String get recipient => '정보 없음';

  String get phone => '정보 없음';

  String get zipCode => '정보 없음';

  String get address => '정보 없음';

  const ShippingInfo({
    this.deliveryOption,
    this.freeShippingApplied,
    this.shippingCostRatio,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    try {
      return _$ShippingInfoFromJson(json);
    } catch (e, s) {
      debugPrint('Error parsing ShippingInfo: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$ShippingInfoToJson(this);
}

@JsonSerializable()
class OrderUserInfo {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'nickName')
  final String name;
  final String email;

  const OrderUserInfo({
    required this.id,
    required this.name,
    required this.email,
  });

  factory OrderUserInfo.fromJson(Map<String, dynamic> json) {
    try {
      return _$OrderUserInfoFromJson(json);
    } catch (e, s) {
      debugPrint('Error parsing OrderUserInfo: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$OrderUserInfoToJson(this);
}

@JsonSerializable()
class StatusHistoryItem {
  @JsonKey(name: 'id')
  final String id;
  final String status;
  final DateTime changedAt;
  final String changedBy;
  final String? note;

  const StatusHistoryItem({
    required this.id,
    required this.status,
    required this.changedAt,
    required this.changedBy,
    this.note,
  });

  factory StatusHistoryItem.fromJson(Map<String, dynamic> json) {
    try {
      return _$StatusHistoryItemFromJson(json);
    } catch (e, s) {
      debugPrint('Error parsing StatusHistoryItem: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$StatusHistoryItemToJson(this);
}
