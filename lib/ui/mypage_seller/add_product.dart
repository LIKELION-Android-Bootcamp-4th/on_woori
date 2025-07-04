import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/styles/app_colors.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/choice_chip.dart';
import '../../widgets/dropdown.dart';

class ProductRegisterPage extends StatefulWidget {
  const ProductRegisterPage({super.key});

  @override
  State<ProductRegisterPage> createState() => _ProductRegisterPageState();
}

class _ProductRegisterPageState extends State<ProductRegisterPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _displayPriceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = ['상의', '하의', '아우터', '잡화'];

  final List<String> _sizes = ['S', 'M', 'L', 'XL', '2XL'];
  final Set<String> _selectedSizes = {};

  File? _selectedImage;

  void _toggleSize(String size) {
    setState(() {
      if (_selectedSizes.contains(size)) {
        _selectedSizes.remove(size);
      } else {
        _selectedSizes.add(size);
      }
    });
  }

  Future<void> _onAddImagePressed() async {
    // TODO: 이미지 선택 구현
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _displayPriceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '신규 상품 등록',
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('대표 이미지'),
            const SizedBox(height: 8),
            Center(child: _imageBox()),

            const SizedBox(height: 24),
            _sectionTitle('상품 이름'),
            const SizedBox(height: 8),
            _textField('(이름)', _nameController),

            const SizedBox(height: 16),
            _sectionTitle('상품 가격 (정가 기준)'),
            const SizedBox(height: 8),
            _textField('200,000', _priceController, isNumber: true),

            const SizedBox(height: 16),
            _sectionTitle('상품 할인율 (미기재시 0%)'),
            const SizedBox(height: 8),
            _textField('Ex : 10', _discountController, isNumber: true),

            const SizedBox(height: 16),
            _sectionTitle('표시 가격 (할인율 반영)'),
            const SizedBox(height: 8),
            _textField('Ex : 180,000', _displayPriceController, isNumber: true),

            const SizedBox(height: 16),
            _sectionTitle('상품 소개글 (최대 nn자)'),
            const SizedBox(height: 8),
            _textField('(소개글)', _descriptionController, maxLines: 3),

            const SizedBox(height: 24),
            _sectionTitle('사이즈 옵션'),
            const SizedBox(height: 8),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 16,
                children: _sizes.map((size) {
                  return CommonChoiceChip(
                    label: size,
                    selected: _selectedSizes.contains(size),
                    onTap: () => _toggleSize(size),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),
            _sectionTitle('카테고리 분류'),
            const SizedBox(height: 8),
            CustomDropdown(
              selectedValue: _selectedCategory ?? _categories[0],
              items: _categories,
              onChanged: (val) {
                setState(() {
                  _selectedCategory = val;
                });
              },
            ),

            const SizedBox(height: 24),
            _sectionTitle('상품 소개 이미지'),
            const SizedBox(height: 8),
            Center(child: _imagePreviewWithButton()),

            const SizedBox(height: 32),
            Center(
              child: BottomButton(
                buttonText: '상품 등록',
                pressedFunc: () {},
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _textField(
      String hint,
      TextEditingController controller, {
        bool isNumber = false,
        int maxLines = 1,
      }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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

  Widget _imageBox() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.optionStateList,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _selectedImage == null
              ? const SizedBox.shrink()
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
              width: 160,
              height: 160,
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: Material(
            color: AppColors.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _onAddImagePressed,
              child: SizedBox(
                width: 44,
                height: 44,
                child: const Icon(Icons.add, color: Colors.black, size: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imagePreviewWithButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.optionStateList,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: Material(
            color: AppColors.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _onAddImagePressed,
              child: SizedBox(
                width: 44,
                height: 44,
                child: const Icon(Icons.add, color: Colors.black, size: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
