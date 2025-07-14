import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UploadFilesRequest {
  final List<XFile> files;

  const UploadFilesRequest({required this.files});

  Future<FormData> toFormData() async {
    final formData = FormData();

    for (final file in files) {
      formData.files.add(
        MapEntry(
          'files', // API 명세에 따른 키
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }

    return formData;
  }
}
