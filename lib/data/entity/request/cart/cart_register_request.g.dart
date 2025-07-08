// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartRegisterRequest _$CartRegisterRequestFromJson(Map<String, dynamic> json) =>
    CartRegisterRequest(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toInt(),
      options: CartOptions.fromJson(json['options'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : CartDiscount.fromJson(json['discount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartRegisterRequestToJson(
  CartRegisterRequest instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'quantity': instance.quantity,
  'unitPrice': instance.unitPrice,
  'options': instance.options.toJson(),
  if (instance.discount?.toJson() case final value?) 'discount': value,
};

CartOptions _$CartOptionsFromJson(Map<String, dynamic> json) =>
    CartOptions(size: json['size'] as String?, color: json['color'] as String?);

Map<String, dynamic> _$CartOptionsToJson(CartOptions instance) =>
    <String, dynamic>{
      if (instance.size case final value?) 'size': value,
      if (instance.color case final value?) 'color': value,
    };

CartDiscount _$CartDiscountFromJson(Map<String, dynamic> json) => CartDiscount(
  type: json['type'] as String,
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$CartDiscountToJson(CartDiscount instance) =>
    <String, dynamic>{'type': instance.type, 'amount': instance.amount};
