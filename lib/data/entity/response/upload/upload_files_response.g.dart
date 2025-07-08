// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_files_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFilesResponse _$UploadFilesResponseFromJson(Map<String, dynamic> json) =>
    UploadFilesResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : UploadFilesData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$UploadFilesResponseToJson(
  UploadFilesResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
  'timestamp': instance.timestamp?.toIso8601String(),
};

UploadFilesData _$UploadFilesDataFromJson(Map<String, dynamic> json) =>
    UploadFilesData(
      files: (json['files'] as List<dynamic>)
          .map((e) => UploadedFileItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UploadFilesDataToJson(UploadFilesData instance) =>
    <String, dynamic>{'files': instance.files.map((e) => e.toJson()).toList()};

UploadedFileItem _$UploadedFileItemFromJson(Map<String, dynamic> json) =>
    UploadedFileItem(
      url: json['url'] as String,
      file: FileDetails.fromJson(json['file'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadedFileItemToJson(UploadedFileItem instance) =>
    <String, dynamic>{'url': instance.url, 'file': instance.file.toJson()};

FileDetails _$FileDetailsFromJson(Map<String, dynamic> json) => FileDetails(
  originalName: json['originalName'] as String,
  filename: json['filename'] as String,
  mimeType: json['mimeType'] as String,
  size: (json['size'] as num).toInt(),
);

Map<String, dynamic> _$FileDetailsToJson(FileDetails instance) =>
    <String, dynamic>{
      'originalName': instance.originalName,
      'filename': instance.filename,
      'mimeType': instance.mimeType,
      'size': instance.size,
    };
