import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePicker extends StatefulWidget {
  const MultiImagePicker({super.key});

  @override
  State<MultiImagePicker> createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];

  // 비동기로 이미지를 여러 장 가져오는 함수
  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedImages = await _picker.pickMultiImage();
      setState(() {
        _images.addAll(pickedImages);
      });
    } catch (e) {
      // 에러 처리
      debugPrint("이미지 선택 중 에러 발생: $e");
    }
  }

  // 선택한 이미지를 리스트에서 삭제하는 함수
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 이미지 선택 버튼
        ElevatedButton.icon(
          onPressed: _pickImages,
          icon: const Icon(Icons.add_photo_alternate_outlined),
          label: const Text("이미지 선택하기"),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 선택된 이미지를 보여주는 영역
        Expanded(
          child: _images.isEmpty
              ? const Center(child: Text("선택된 이미지가 없습니다."))
              : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 한 줄에 3개의 이미지
              crossAxisSpacing: 8, // 수평 간격
              mainAxisSpacing: 8, // 수직 간격
            ),
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // 이미지 표시
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(File(_images[index].path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // 삭제 버튼
                  Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _removeImage(index),
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}