import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/styles/app_colors.dart';
import '../../widgets/bottom_button.dart';

class BrandEditPage extends StatefulWidget {
  const BrandEditPage({super.key});

  @override
  State<BrandEditPage> createState() => _BrandEditPageState();
}

class _BrandEditPageState extends State<BrandEditPage> {
  final _nameController = TextEditingController();
  final _introController = TextEditingController();
  File? _selectedImage;

  Future<void> _onAddImagePressed() async {
    // TODO: 이미지 선택 로직
  }

  @override
  void dispose() {
    _nameController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '브랜드 수정',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Center(child: _circleImageBox()),

            const SizedBox(height: 24),
            _sectionTitle('브랜드 이름'),
            const SizedBox(height: 8),
            _textField('(이름)', _nameController),

            const SizedBox(height: 16),
            _sectionTitle('브랜드 소개'),
            const SizedBox(height: 8),
            _textField('(소개글) (최대 nn자)', _introController, maxLines: 3),

            const SizedBox(height: 16),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BottomButton(
            buttonText: '저장',
            pressedFunc: () {
              // TODO: 저장 처리
            },
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget _textField(
      String hint,
      TextEditingController controller, {
        int maxLines = 1,
      }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.grey[400],
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.DividerTextBoxLineDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.DividerTextBoxLineDivider),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  Widget _circleImageBox() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.optionStateList,
            shape: BoxShape.circle,
          ),
          child: _selectedImage == null
              ? const SizedBox.shrink()
              : ClipOval(
            child: Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
          ),
        ),
        Positioned(
          bottom: -2,
          right: -2,
          child: Material(
            color: AppColors.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _onAddImagePressed,
              child: SizedBox(
                width: 33,
                height: 33,
                child: const Icon(Icons.add, color: Colors.black, size: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
