import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/entity/request/products/product_register_request.dart';
import 'package:on_woori/data/client/upload_api_client.dart';
import 'package:on_woori/data/entity/request/upload/upload_files_request.dart';
import 'package:on_woori/l10n/app_localizations.dart';

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
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = ['상의', '하의', '아우터', '잡화'];
  final List<String> _sizes = ['S', 'M', 'L', 'XL', '2XL'];
  final Set<String> _selectedSizes = {};
  File? _thumbnailImageFile;

  final List<XFile> _detailImages = [];
  bool _isLoading = false;

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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _thumbnailImageFile = File(picked.path));
  }

  Future<void> _pickDetailImages() async {
    final l10n = AppLocalizations.of(context)!;
    if (_detailImages.length >= 5) {
      _showSnackBar(l10n.productRegisterErrorMaxImages);
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
          _showSnackBar(l10n.productRegisterErrorMaxImages);
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

  Future<void> _registerProduct() async {
    final l10n = AppLocalizations.of(context)!;

    if (_thumbnailImageFile == null) {
      _showSnackBar(l10n.productRegisterErrorNoThumbnail);
      return;
    }
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
      _showSnackBar(l10n.productRegisterErrorNoNamePrice);
      return;
    }
    if (_selectedSizes.isEmpty) {
      _showSnackBar(l10n.productRegisterErrorNoSize);
      return;
    }
    if (_nameController.text.length < 2) {
      _showSnackBar(l10n.productRegisterErrorLength);
      return;
    }

    setState(() => _isLoading = true);

    try {
      List<String> detailImageUrls = [];
      if (_detailImages.isNotEmpty) {
        final uploadRequest = UploadFilesRequest(files: _detailImages);
        final uploadResponse = await UploadApiClient().uploadFiles(
          uploadRequest,
        );

        if (uploadResponse.success && uploadResponse.data != null) {
          detailImageUrls =
              uploadResponse.data!.files.map((file) => file.url).toList();
        } else {
          _showSnackBar(
              l10n.productRegisterErrorImageUploadFailed(uploadResponse.message));
          setState(() => _isLoading = false);
          return;
        }
      }

      final productRequest = ProductRegisterRequest(
        name: _nameController.text,
        price: int.tryParse(_priceController.text) ?? 0,
        description: _descriptionController.text,
        category: _selectedCategory ?? _categories[0],
        sizes: _selectedSizes,
        discount: int.tryParse(_discountController.text),
        thumbnailImage: _thumbnailImageFile,
        detailImageUrls: detailImageUrls,
      );

      final productResponse = await ProductsApiClient().productRegister(
        await productRequest.toFormData(),
      );

      if (mounted && productResponse.success) {
        _showSnackBar(l10n.productRegisterSuccess, isError: false);
        context.pop();
      } else if (mounted) {
        _showSnackBar(l10n.productRegisterErrorFailed(productResponse.message));
      }
    } catch (e) {
      _showSnackBar(l10n.productRegisterErrorUnexpected('$e'));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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
    final l10n = AppLocalizations.of(context)!;
    final price = int.tryParse(_priceController.text) ?? 0;
    final discount = int.tryParse(_discountController.text) ?? 0;
    final displayPrice = (price * (100 - discount) / 100).round();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.productRegisterPageTitle,
          style: const TextStyle(
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _centeredSectionTitle(l10n.productRegisterThumbnailImageLabel),
                  const SizedBox(height: 8),
                  Center(child: _imageBox()),
                  const SizedBox(height: 24),
                  _sectionTitle(l10n.productRegisterNameLabel),
                  const SizedBox(height: 8),
                  _textField(l10n.productRegisterNameHint, _nameController),
                  const SizedBox(height: 16),
                  _sectionTitle(l10n.productRegisterPriceLabel),
                  const SizedBox(height: 8),
                  _textField(
                    l10n.productRegisterPriceHint,
                    _priceController,
                    isNumber: true,
                    onChanged: (_) => setState(() {}),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  _sectionTitle(l10n.productRegisterDiscountLabel),
                  const SizedBox(height: 8),
                  _textField(
                    l10n.productRegisterDiscountHint,
                    _discountController,
                    isNumber: true,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        final intValue = int.tryParse(value);
                        if (intValue != null && intValue > 100) {
                          _discountController.text = '100';
                          _discountController.selection =
                              TextSelection.fromPosition(
                                TextPosition(offset: _discountController.text.length),
                              );
                        }
                      }
                      setState(() {});
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  _sectionTitle(l10n.productRegisterDisplayPriceLabel),
                  const SizedBox(height: 8),
                  _displayField(displayPrice),
                  const SizedBox(height: 16),
                  _sectionTitle(l10n.productRegisterDescriptionLabel),
                  const SizedBox(height: 8),
                  _textField(
                      l10n.productRegisterDescriptionHint, _descriptionController,
                      maxLines: 3),
                  const SizedBox(height: 24),
                  _sectionTitle(l10n.productRegisterSizeOptionLabel),
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
                  _sectionTitle(l10n.productRegisterCategoryLabel),
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
                  _centeredSectionTitle(l10n.productRegisterDetailImageLabel),
                  const SizedBox(height: 8),
                  _buildDetailImagePicker(),
                  const SizedBox(height: 32),
                  Center(
                    child: BottomButton(
                      buttonText: l10n.productRegisterButton,
                      pressedFunc: _registerProduct,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
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

  Widget _centeredSectionTitle(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textField(
      String hint,
      TextEditingController controller, {
        bool isNumber = false,
        int maxLines = 1,
        bool isEnabled = true,
        void Function(String)? onChanged,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      enabled: isEnabled,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.grey[400],
        ),
        filled: !isEnabled,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.dividerTextBoxLineDivider,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.dividerTextBoxLineDivider,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.dividerTextBoxLineDivider,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _displayField(int price) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.dividerTextBoxLineDivider,
        ),
      ),
      child: Text(
        NumberFormat('#,###').format(price),
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black,
        ),
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
          child: _thumbnailImageFile == null
              ? const Center(
            child: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.grey,
              size: 40,
            ),
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(_thumbnailImageFile!, fit: BoxFit.cover),
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
              onTap: _pickImage,
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.add, color: Colors.black, size: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailImagePicker() {
    final l10n = AppLocalizations.of(context)!;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.grey,
                    size: 30,
                  ),
                  const SizedBox(height: 4),
                  Text(l10n.productRegisterAddDetailImage,
                      style: const TextStyle(color: AppColors.grey)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
