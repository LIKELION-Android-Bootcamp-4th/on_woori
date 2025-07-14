import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/client/upload_api_client.dart';
import 'package:on_woori/data/entity/request/upload/upload_files_request.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

import '../../core/styles/app_colors.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/choice_chip.dart';
import '../../widgets/dropdown.dart';

class ProductEditPage extends StatefulWidget {
  final String productId;
  const ProductEditPage({super.key, required this.productId});

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final _formKey = GlobalKey<FormState>();

  // 컨트롤러
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _descriptionController = TextEditingController();

  // 데이터 상태
  String? _selectedCategory;
  final List<String> _categories = ['상의', '하의', '아우터', '잡화'];
  final List<String> _sizes = ['S', 'M', 'L', 'XL', '2XL'];
  final Set<String> _selectedSizes = {};

  File? _thumbnailImageFile; // 새로 선택한 대표 이미지 (로컬 파일)
  String? _existingThumbnailUrl; // 기존 대표 이미지 URL
  final List<XFile> _detailImages = []; // 새로 추가할 상세 이미지 목록

  // 로딩 상태
  bool _isFetching = true; // 초기 데이터 로딩 상태
  bool _isSaving = false; // 저장(업데이트) 중 로딩 상태

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      final response = await ProductsApiClient().productDetail(widget.productId);

      if (mounted && response.success && response.data != null) {
        final product = response.data!;

        // 받아온 데이터로 컨트롤러와 상태 변수 초기화
        _nameController.text = product.name;
        _priceController.text = product.price.toString();
        _discountController.text = product.discount?.toString() ?? '';
        _descriptionController.text = product.description;

        _selectedCategory = product.category;

        final sizeOptionGroup = product.options?.firstWhere(
              (opt) => opt.name == '사이즈',
          orElse: () => ProductOptionGroup(type: '', name: '', items: []),
        );
        _selectedSizes.addAll(sizeOptionGroup!.items.map((item) => item.code));

        _existingThumbnailUrl = product.thumbnailImage?.url;
        // ✨ 기존 상세 이미지 URL은 불러오지 않음
      } else {
        _showSnackBar(response.message);
        if(mounted) context.pop();
      }
    } catch (e) {
      _showSnackBar('상품 정보를 불러오는 데 실패했습니다: $e');
      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _isFetching = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _toggleSize(String size) {
    setState(() {
      if (_selectedSizes.contains(size)) {
        _selectedSizes.remove(size);
      } else {
        _selectedSizes.add(size);
      }
    });
  }

  Future<void> _pickThumbnailImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _thumbnailImageFile = File(picked.path);
      });
    }
  }

  // ✨ --- '상품 등록' 페이지와 동일한 이미지 선택/제거 로직 ---
  Future<void> _pickDetailImages() async {
    if (_detailImages.length >= 5) {
      _showSnackBar('이미지는 최대 5개까지 등록할 수 있습니다.');
      return;
    }
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      final combinedImages = _detailImages + pickedImages;
      setState(() {
        if (combinedImages.length > 5) {
          _detailImages.clear();
          _detailImages.addAll(combinedImages.take(5));
          _showSnackBar('이미지는 최대 5개까지만 등록할 수 있습니다.');
        } else {
          _detailImages.addAll(pickedImages);
        }
      });
    }
  }

  void _removeDetailImage(int index) {
    setState(() {
      _detailImages.removeAt(index);
    });
  }

  Future<void> _updateProduct() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
      _showSnackBar('상품 이름과 가격은 필수입니다.');
      return;
    }
    if (_selectedSizes.isEmpty) {
      _showSnackBar('사이즈 옵션을 하나 이상 선택해주세요.');
      return;
    }

    setState(() => _isSaving = true);

    try {
      List<String> detailImageUrls = [];
      if (_detailImages.isNotEmpty) {
        final uploadRequest = UploadFilesRequest(files: _detailImages);
        final uploadResponse = await UploadApiClient().uploadFiles(uploadRequest);

        if (uploadResponse.success && uploadResponse.data != null) {
          detailImageUrls = uploadResponse.data!.files.map((file) => file.url).toList();
        } else {
          _showSnackBar('상세 이미지 업로드에 실패했습니다: ${uploadResponse.message}');
          setState(() => _isSaving = false);
          return;
        }
      }

      final imagesJson = {
        "detail": detailImageUrls,
      };

      final sizeOptionsJson = {
        "type": "size",
        "name": "사이즈",
        "items": _selectedSizes.map((size) => {"code": size}).toList(),
      };

      // 2. '기본' 값을 가진 컬러 옵션 그룹 생성
      final colorOptionsJson = {
        "type": "color",
        "name": "컬러",
        "items": [{"code": "기본"}],
      };

      final optionsList = [sizeOptionsJson, colorOptionsJson];


      final jsondetailImages = jsonEncode(imagesJson);

      // 2. 상품 수정을 위한 FormData를 생성합니다.
      final formData = FormData.fromMap({
        'name': _nameController.text,
        'price': int.tryParse(_priceController.text) ?? 0,
        'description': _descriptionController.text,
        'category': _selectedCategory ?? _categories[0],
        'options': jsonEncode(optionsList),
        'discount': int.tryParse(_discountController.text),
        'images': jsondetailImages, // 새로 업로드된 이미지 URL 목록을 전송
      });

      // 3. 새 대표 이미지를 선택했다면 FormData에 파일로 추가합니다.
      if (_thumbnailImageFile != null) {
        formData.files.add(MapEntry(
          'thumbnailImage',
          await MultipartFile.fromFile(_thumbnailImageFile!.path),
        ));
      }

      // 4. 상품 수정 API를 호출합니다.
      await ProductsApiClient().productUpdate(id: widget.productId, formData: formData);
      debugPrint("API로 전송될 FormData: ${formData.fields}");
      debugPrint("첨부된 대표 이미지: ${_thumbnailImageFile?.path}");

      await Future.delayed(const Duration(seconds: 2)); // API 호출 흉내

      if (mounted) {
        _showSnackBar('상품이 성공적으로 수정되었습니다.', isError: false);
        context.pop(true);
      }
    } catch (e) {
      _showSnackBar('상품 수정 중 오류가 발생했습니다: $e');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isFetching) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final price = int.tryParse(_priceController.text) ?? 0;
    final discount = int.tryParse(_discountController.text) ?? 0;
    final displayPrice = (price * (100 - discount) / 100).round();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text('상품 수정', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 100),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _centeredSectionTitle('대표 이미지'),
                  const SizedBox(height: 8),
                  Center(child: _thumbnailImageBox()),

                  const SizedBox(height: 24),
                  _sectionTitle('상품 이름'),
                  const SizedBox(height: 8),
                  _textField(_nameController, hint: '(이름)'),

                  const SizedBox(height: 16),
                  _sectionTitle('상품 가격 (정가 기준)'),
                  const SizedBox(height: 8),
                  _textField(_priceController, hint: '200,000', isNumber: true),

                  const SizedBox(height: 16),
                  _sectionTitle('상품 할인율 (미기재시 0%)'),
                  const SizedBox(height: 8),
                  _textField(_discountController, hint: 'Ex : 10', isNumber: true),

                  const SizedBox(height: 16),
                  _sectionTitle('표시 가격 (할인율 반영)'),
                  const SizedBox(height: 8),
                  _textField(TextEditingController(text: '$displayPrice'), isEnabled: false),

                  const SizedBox(height: 16),
                  _sectionTitle('상품 소개글'),
                  const SizedBox(height: 8),
                  _textField(_descriptionController, hint: '(소개글)', maxLines: 3),

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
                      setState(() => _selectedCategory = val);
                    },
                  ),

                  const SizedBox(height: 24),
                  _centeredSectionTitle('상품 소개 이미지 (선택)'),
                  const SizedBox(height: 8),
                  _buildDetailImagePicker(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: BottomButton(
                buttonText: '상품 수정',
                pressedFunc: _updateProduct,
              ),
            ),
          ),
          if (_isSaving)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black));
  Widget _centeredSectionTitle(String title) => Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black)));

  Widget _textField(TextEditingController controller, {String? hint, bool isNumber = false, int maxLines = 1, bool isEnabled = true}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      enabled: isEnabled,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey[400]),
        filled: !isEnabled,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.dividerTextBoxLineDivider)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.dividerTextBoxLineDivider)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.dividerTextBoxLineDivider)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  Widget _thumbnailImageBox() {
    ImageProvider? imageProvider;
    if (_thumbnailImageFile != null) {
      imageProvider = FileImage(_thumbnailImageFile!);
    } else if (_existingThumbnailUrl != null && _existingThumbnailUrl!.isNotEmpty) {
      imageProvider = NetworkImage(_existingThumbnailUrl!);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.optionStateList,
            borderRadius: BorderRadius.circular(12),
            image: imageProvider != null ? DecorationImage(image: imageProvider, fit: BoxFit.cover) : null,
          ),
          child: imageProvider == null
              ? const Center(child: Icon(Icons.camera_alt_outlined, color: AppColors.grey, size: 40))
              : null,
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: Material(
            color: AppColors.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _pickThumbnailImage,
              child: const SizedBox(width: 44, height: 44, child: Icon(Icons.add, color: Colors.black, size: 24)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailImagePicker() {
    return Column(
      children: [
        if (_detailImages.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _detailImages.length,
            itemBuilder: (context, index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(File(_detailImages[index].path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -12,
                    right: -12,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _removeDetailImage(index),
                      color: Colors.redAccent,
                      iconSize: 28,
                    ),
                  ),
                ],
              );
            },
          ),
        const SizedBox(height: 16),

        if (_detailImages.length < 5)
          GestureDetector(
            onTap: _pickDetailImages,
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.optionStateList,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, color: AppColors.grey, size: 30),
                  SizedBox(height: 4),
                  Text('상세 이미지 추가', style: TextStyle(color: AppColors.grey)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
