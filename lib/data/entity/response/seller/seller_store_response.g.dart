// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_store_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerStoreResponse _$SellerStoreResponseFromJson(Map<String, dynamic> json) =>
    SellerStoreResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: StoreData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerStoreResponseToJson(
  SellerStoreResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

StoreData _$StoreDataFromJson(Map<String, dynamic> json) => StoreData(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
  images: Images.fromJson(json['images'] as Map<String, dynamic>),
  deliveryFee: (json['deliveryFee'] as num).toInt(),
  companyId: json['companyId'] as String,
  ownerId: json['ownerId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$StoreDataToJson(StoreData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'contact': instance.contact.toJson(),
  'address': instance.address.toJson(),
  'images': instance.images.toJson(),
  'deliveryFee': instance.deliveryFee,
  'companyId': instance.companyId,
  'ownerId': instance.ownerId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
  phone: json['phone'] as String,
  email: json['email'] as String,
  kakaoTalk: json['kakaoTalk'] as String,
);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'phone': instance.phone,
  'email': instance.email,
  'kakaoTalk': instance.kakaoTalk,
};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  street: json['street'] as String,
  city: json['city'] as String,
  zipCode: json['zipCode'] as String,
  coordinates: Coordinates.fromJson(
    json['coordinates'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'street': instance.street,
  'city': instance.city,
  'zipCode': instance.zipCode,
  'coordinates': instance.coordinates.toJson(),
};

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

Images _$ImagesFromJson(Map<String, dynamic> json) =>
    Images(logo: json['logo'] as String);

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
  'logo': instance.logo,
};
