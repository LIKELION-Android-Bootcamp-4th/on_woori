import 'package:json_annotation/json_annotation.dart';

part 'upload_files_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadFilesResponse {
  final bool success;
  final String message;
  final UploadFilesData? data;
  final DateTime? timestamp;

  const UploadFilesResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory UploadFilesResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadFilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFilesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UploadFilesData {
  final List<UploadedFileItem> files;

  const UploadFilesData({required this.files});

  factory UploadFilesData.fromJson(Map<String, dynamic> json) =>
      _$UploadFilesDataFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFilesDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UploadedFileItem {
  final String url;
  final FileDetails file;

  const UploadedFileItem({required this.url, required this.file});

  factory UploadedFileItem.fromJson(Map<String, dynamic> json) =>
      _$UploadedFileItemFromJson(json);

  Map<String, dynamic> toJson() => _$UploadedFileItemToJson(this);
}

@JsonSerializable()
class FileDetails {
  final String originalName;
  final String filename;
  final String mimeType;
  final int size;

  const FileDetails({
    required this.originalName,
    required this.filename,
    required this.mimeType,
    required this.size,
  });

  factory FileDetails.fromJson(Map<String, dynamic> json) =>
      _$FileDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FileDetailsToJson(this);
}
