import 'package:json_annotation/json_annotation.dart';

part 'seller_store_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SellerStoreResponse {
  final bool success;
  final String message;
  final StoreData data;

  SellerStoreResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SellerStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$SellerStoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SellerStoreResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StoreData {
  final String id;
  final String name;
  final String description;
  final Contact contact;
  final Address address;
  final Images images;
  final int deliveryFee;
  final String companyId;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  StoreData({
    required this.id,
    required this.name,
    required this.description,
    required this.contact,
    required this.address,
    required this.images,
    required this.deliveryFee,
    required this.companyId,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) =>
      _$StoreDataFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDataToJson(this);
}

@JsonSerializable()
class Contact {
  final String phone;
  final String email;
  final String kakaoTalk;

  Contact({
    required this.phone,
    required this.email,
    required this.kakaoTalk,
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Address {
  final String street;
  final String city;
  final String zipCode;
  final Coordinates coordinates;

  Address({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Coordinates {
  final double lat;
  final double lng;

  Coordinates({
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

@JsonSerializable()
class Images {
  final String logo;

  Images({
    required this.logo,
  });

  factory Images.fromJson(Map<String, dynamic> json) =>
      _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
