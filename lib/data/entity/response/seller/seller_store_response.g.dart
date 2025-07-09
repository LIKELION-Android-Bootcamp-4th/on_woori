// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_store_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerStoreResponse _$SellerStoreResponseFromJson(Map<String, dynamic> json) =>
    SellerStoreResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : StoreData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$SellerStoreResponseToJson(
  SellerStoreResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
  'timestamp': instance.timestamp,
};

StoreData _$StoreDataFromJson(Map<String, dynamic> json) => StoreData(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  owner: json['owner'] == null
      ? null
      : OwnerData.fromJson(json['owner'] as Map<String, dynamic>),
  companyId: json['companyId'] as String?,
  shippingPolicy: json['shippingPolicy'] == null
      ? null
      : ShippingPolicy.fromJson(json['shippingPolicy'] as Map<String, dynamic>),
  status: json['status'] as String?,
  isDeleted: json['isDeleted'] as bool?,
  category: json['category'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  thumbnailImage: json['thumbnailImage'],
  thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
  coverImage: json['coverImage'],
  coverImageUrl: json['coverImageUrl'] as String?,
  bannerImage: json['bannerImage'],
  bannerImageUrl: json['bannerImageUrl'] as String?,
);

Map<String, dynamic> _$StoreDataToJson(StoreData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'owner': instance.owner?.toJson(),
  'companyId': instance.companyId,
  'shippingPolicy': instance.shippingPolicy?.toJson(),
  'status': instance.status,
  'isDeleted': instance.isDeleted,
  'category': instance.category,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'thumbnailImage': instance.thumbnailImage,
  'thumbnailImageUrl': instance.thumbnailImageUrl,
  'coverImage': instance.coverImage,
  'coverImageUrl': instance.coverImageUrl,
  'bannerImage': instance.bannerImage,
  'bannerImageUrl': instance.bannerImageUrl,
};

OwnerData _$OwnerDataFromJson(Map<String, dynamic> json) => OwnerData(
  id: json['id'] as String?,
  email: json['email'] as String?,
  nickName: json['nickName'] as String?,
  profile: json['profile'] == null
      ? null
      : Profile.fromJson(json['profile'] as Map<String, dynamic>),
  loginRoles: (json['loginRoles'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  platformRoles: (json['platformRoles'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isActive: json['isActive'] as bool?,
  needEmailVerification: json['needEmailVerification'] as bool?,
  emailVerified: json['emailVerified'] as bool?,
  companyId: json['companyId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$OwnerDataToJson(OwnerData instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'nickName': instance.nickName,
  'profile': instance.profile?.toJson(),
  'loginRoles': instance.loginRoles,
  'platformRoles': instance.platformRoles,
  'isActive': instance.isActive,
  'needEmailVerification': instance.needEmailVerification,
  'emailVerified': instance.emailVerified,
  'companyId': instance.companyId,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
  name: json['name'] as String?,
  profileImage: json['profileImage'] as String?,
  birthDate: json['birthDate'] as String?,
);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'name': instance.name,
  'profileImage': instance.profileImage,
  'birthDate': instance.birthDate,
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
