import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class ProductRegisterRequest {
  final String name;
  final int price;
  final String description;
  final String category;
  final Set<String> sizes;
  final int? discount;
  final File? thumbnailImage;
  final List<String>? detailImageUrls;

  const ProductRegisterRequest({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.sizes,
    this.discount,
    this.thumbnailImage,
    this.detailImageUrls,
  });

  Future<FormData> toFormData() async {
    final optionsJson = {
      "type": "size",
      "name": "사이즈",
      "items": sizes.map((size) => {"code": size}).toList(),
    };

    final imagesJson = {
      "detail": detailImageUrls ?? [],
    };

    final Map<String, dynamic> formDataMap = {
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'options': jsonEncode([optionsJson]),
      'stockType': 'fixed',
      'status': 'on_sale',
      'discount': discount ?? '',
      'stock': '',
      'attributes': '',
      'images': jsonEncode(imagesJson),
    };

    if (thumbnailImage != null) {
      formDataMap['thumbnailImage'] = await MultipartFile.fromFile(
        thumbnailImage!.path,
        filename: thumbnailImage!.path.split('/').last,
      );
    }

    return FormData.fromMap(formDataMap);
  }
}