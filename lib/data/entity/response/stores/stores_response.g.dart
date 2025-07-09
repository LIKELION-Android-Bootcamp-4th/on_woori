// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoresResponse _$StoresResponseFromJson(Map<String, dynamic> json) =>
    StoresResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : StoresData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$StoresResponseToJson(StoresResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };

StoresData _$StoresDataFromJson(Map<String, dynamic> json) => StoresData(
  items: (json['items'] as List<dynamic>)
      .map((e) => StoreItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: _paginationFromJson(json['pagination']),
);

Map<String, dynamic> _$StoresDataToJson(StoresData instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
    };

StoreItem _$StoreItemFromJson(Map<String, dynamic> json) => StoreItem(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  owner: json['owner'] as String,
  companyId: json['companyId'] as String,
  status: json['status'] as String,
  isDeleted: json['isDeleted'] as bool,
  category: json['category'] as String?,
  shippingPolicy: json['shippingPolicy'] == null
      ? null
      : ShippingPolicy.fromJson(json['shippingPolicy'] as Map<String, dynamic>),
  contact: _contactFromJson(json['contact']),
  address: _addressFromJson(json['address']),
  thumbnailImage: _thumbnailImageFromJson(json['thumbnailImage']),
  thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  bannerImageUrl: json['bannerImageUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$StoreItemToJson(StoreItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'owner': instance.owner,
  'companyId': instance.companyId,
  'status': instance.status,
  'isDeleted': instance.isDeleted,
  'category': instance.category,
  'shippingPolicy': instance.shippingPolicy?.toJson(),
  'contact': instance.contact?.toJson(),
  'address': instance.address?.toJson(),
  'thumbnailImage': instance.thumbnailImage?.toJson(),
  'thumbnailImageUrl': instance.thumbnailImageUrl,
  'coverImageUrl': instance.coverImageUrl,
  'bannerImageUrl': instance.bannerImageUrl,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

ShippingPolicy _$ShippingPolicyFromJson(Map<String, dynamic> json) =>
    ShippingPolicy(
      defaultShippingCost: (json['defaultShippingCost'] as num?)?.toInt(),
      freeShippingThreshold: (json['freeShippingThreshold'] as num?)?.toInt(),
      freeShippingEnabled: json['freeShippingEnabled'] as bool?,
    );

Map<String, dynamic> _$ShippingPolicyToJson(ShippingPolicy instance) =>
    <String, dynamic>{
      'defaultShippingCost': instance.defaultShippingCost,
      'freeShippingThreshold': instance.freeShippingThreshold,
      'freeShippingEnabled': instance.freeShippingEnabled,
    };

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
  kakaoTalk: json['kakaoTalk'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'kakaoTalk': instance.kakaoTalk,
  'phone': instance.phone,
  'email': instance.email,
  'website': instance.website,
};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  street: json['street'] as String?,
  detail: json['detail'] as String?,
  zipCode: json['zipCode'] as String?,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'street': instance.street,
  'detail': instance.detail,
  'zipCode': instance.zipCode,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalItems: (json['total'] as num).toInt(),
  itemsPerPage: (json['limit'] as num).toInt(),
  hasNextPage: json['hasNext'] as bool,
  hasPrevPage: json['hasPrev'] as bool,
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'total': instance.totalItems,
      'limit': instance.itemsPerPage,
      'hasNext': instance.hasNextPage,
      'hasPrev': instance.hasPrevPage,
    };

StoreOwner _$StoreOwnerFromJson(Map<String, dynamic> json) => StoreOwner(
  id: json['id'] as String,
  nickName: json['nickName'] as String,
  profile: StoreOwnerProfile.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoreOwnerToJson(StoreOwner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'profile': instance.profile,
    };

StoreDetailResponse _$StoreDetailResponseFromJson(Map<String, dynamic> json) =>
    StoreDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: StoreDetailItem.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$StoreDetailResponseToJson(
  StoreDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};

StoreDetailItem _$StoreDetailItemFromJson(Map<String, dynamic> json) =>
    StoreDetailItem(
      id: json['id'] as String,
      name: json['name'] as String,
      owner: StoreOwner.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String,
    );

Map<String, dynamic> _$StoreDetailItemToJson(StoreDetailItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
      'description': instance.description,
    };

StoreOwnerProfile _$StoreOwnerProfileFromJson(Map<String, dynamic> json) =>
    StoreOwnerProfile(
      name: json['name'] as String,
      profileImage: json['profileImage'] as String,
    );

Map<String, dynamic> _$StoreOwnerProfileToJson(StoreOwnerProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profileImage': instance.profileImage,
    };

StoreProductsResponse _$StoreProductsResponseFromJson(
  Map<String, dynamic> json,
) => StoreProductsResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$StoreProductsResponseToJson(
  StoreProductsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'timestamp': instance.timestamp.toIso8601String(),
};

SellerStoreResponse _$SellerStoreResponseFromJson(Map<String, dynamic> json) =>
    SellerStoreResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SellerStoreData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerStoreResponseToJson(
  SellerStoreResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

SellerStoreData _$SellerStoreDataFromJson(Map<String, dynamic> json) =>
    SellerStoreData(
      name: json['name'] as String,
      description: json['description'] as String?,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      id: json['id'] as String,
      category: json['category'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SellerStoreDataToJson(SellerStoreData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'id': instance.id,
      'category': instance.category,
      'status': instance.status,
    };

SellerContact _$SellerContactFromJson(Map<String, dynamic> json) =>
    SellerContact(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      kakaoTalk: json['kakaoTalk'] as String?,
    );

Map<String, dynamic> _$SellerContactToJson(SellerContact instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'kakaoTalk': instance.kakaoTalk,
    };

BrandProfileImageData _$BrandProfileImageDataFromJson(
  Map<String, dynamic> json,
) => BrandProfileImageData(
  id: json['id'] as String?,
  originalName: json['originalName'] as String?,
  filename: json['filename'] as String?,
  mimeType: json['mimeType'] as String?,
  size: json['size'] as String?,
  url: json['url'] as String,
);

Map<String, dynamic> _$BrandProfileImageDataToJson(
  BrandProfileImageData instance,
) => <String, dynamic>{
  'id': instance.id,
  'originalName': instance.originalName,
  'filename': instance.filename,
  'mimeType': instance.mimeType,
  'size': instance.size,
  'url': instance.url,
};
