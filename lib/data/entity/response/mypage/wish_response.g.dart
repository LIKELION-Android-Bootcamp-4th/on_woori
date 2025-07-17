// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishResponse _$WishResponseFromJson(Map<String, dynamic> json) => WishResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : WishData.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$WishResponseToJson(WishResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp?.toIso8601String(),
    };

WishData _$WishDataFromJson(Map<String, dynamic> json) => WishData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => WishItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WishDataToJson(WishData instance) => <String, dynamic>{
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'pagination': instance.pagination?.toJson(),
};

WishItem _$WishItemFromJson(Map<String, dynamic> json) => WishItem(
  id: json['id'] as String,
  entityType: json['entityType'] as String,
  entityId: json['entityId'] as String,
  entity: json['entity'] == null
      ? null
      : WishProductEntity.fromJson(json['entity'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  store: json['store'] == null
      ? null
      : StoreData.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WishItemToJson(WishItem instance) => <String, dynamic>{
  'id': instance.id,
  'entityType': instance.entityType,
  'entityId': instance.entityId,
  'entity': instance.entity?.toJson(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'store': instance.store?.toJson(),
};

ThumbnailImage _$ThumbnailImageFromJson(Map<String, dynamic> json) =>
    ThumbnailImage(
      id: json['id'] as String,
      originalName: json['originalName'] as String?,
      filename: json['filename'] as String?,
      mimeType: json['mimeType'] as String?,
      size: (json['size'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ThumbnailImageToJson(ThumbnailImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalName': instance.originalName,
      'filename': instance.filename,
      'mimeType': instance.mimeType,
      'size': instance.size,
      'url': instance.url,
    };

WishProductEntity _$WishProductEntityFromJson(Map<String, dynamic> json) =>
    WishProductEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      images: _wishImagesFromJson(json['images'] as String?),
      thumbnailImage: json['thumbnailImage'] == null
          ? null
          : ThumbnailImage.fromJson(
              json['thumbnailImage'] as Map<String, dynamic>,
            ),
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      contentImage: json['contentImage'],
      contentImageUrl: json['contentImageUrl'] as String?,
    );

Map<String, dynamic> _$WishProductEntityToJson(WishProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'images': instance.images,
      'thumbnailImage': instance.thumbnailImage,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'contentImage': instance.contentImage,
      'contentImageUrl': instance.contentImageUrl,
    };

PaginationData _$PaginationDataFromJson(Map<String, dynamic> json) =>
    PaginationData(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      itemsPerPage: (json['itemsPerPage'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPrevPage: json['hasPrevPage'] as bool,
    );

Map<String, dynamic> _$PaginationDataToJson(PaginationData instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'itemsPerPage': instance.itemsPerPage,
      'hasNextPage': instance.hasNextPage,
      'hasPrevPage': instance.hasPrevPage,
    };
