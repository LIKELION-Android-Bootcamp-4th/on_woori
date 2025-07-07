// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartRequest _$CartRequestFromJson(Map<String, dynamic> json) => CartRequest(
  cartIds: (json['cartIds'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CartRequestToJson(CartRequest instance) =>
    <String, dynamic>{'cartIds': instance.cartIds};
