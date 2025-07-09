// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_checkout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartCheckoutRequest _$CartCheckoutRequestFromJson(Map<String, dynamic> json) =>
    CartCheckoutRequest(
      cartIds: (json['cartIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CartCheckoutRequestToJson(
  CartCheckoutRequest instance,
) => <String, dynamic>{'cartIds': instance.cartIds};
