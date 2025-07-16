import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_woori/data/client/seller_fundings_api_client.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import '../../core/styles/app_colors.dart';
import '../../widgets/bottom_button.dart';

class FundingRegisterPage extends StatefulWidget {
  const FundingRegisterPage({super.key});

  @override
  State<FundingRegisterPage> createState() => _FundingRegisterPageState();
}

class _FundingRegisterPageState extends State<FundingRegisterPage> {
  final _nameController = TextEditingController();
  final _linkController = TextEditingController();
  final fundingApiClient = SellerFundingsApiClient();

  File? _thumbnailImageFile;
  bool _isPickingImage = false;
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) {
      debugPrint('이미 이미지 선택 중입니다.');
      return;
    }

    setState(() {
      _isPickingImage = true;
    });

    final ImagePicker picker = ImagePicker();
    final l10n = AppLocalizations.of(context)!;

    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(l10n.fundingRegisterCamera),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? picked = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 85,
                  );
                  if (!mounted) return;
                  setState(() {
                    if (picked != null) {
                      _thumbnailImageFile = File(picked.path);
                    }
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.fundingRegisterGallery),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? picked = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 85,
                  );
                  if (!mounted) return;
                  setState(() {
                    if (picked != null) {
                      _thumbnailImageFile = File(picked.path);
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  void submit() async {
    final l10n = AppLocalizations.of(context)!;

    if (_nameController.text.isEmpty || _linkController.text.isEmpty) {
      _showSnackBar(l10n.validatorRequired);
      return;
    }

    if (_thumbnailImageFile == null) {
      _showSnackBar(l10n.productRegisterErrorNoThumbnail);
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final res = await fundingApiClient.createFunding(
        title: _nameController.text,
        linkUrl: _linkController.text,
        thumbnailImage: _thumbnailImageFile,
      );

      if (mounted) {
        if (res.statusCode == 201 || res.statusCode == 200) {
          _showSnackBar("펀딩을 등록했습니다.", isError: false);
          context.pop(true); // 성공 시 true 반환
        } else {
          final errorMessage = (res.data is Map<String, dynamic>)
              ? res.data['message'] ?? '알 수 없는 오류가 발생했습니다.'
              : res.statusMessage ?? '펀딩 생성에 실패했습니다.';
          _showSnackBar('생성 실패: $errorMessage');
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('오류가 발생했습니다: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.fundingRegisterPageTitle,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _sectionTitle(l10n.fundingRegisterThumbnailLabel)),
                const SizedBox(height: 8),
                Center(child: _imageBox()),
                const SizedBox(height: 24),
                _sectionTitle(l10n.fundingRegisterNameLabel),
                const SizedBox(height: 8),
                _textField(l10n.fundingRegisterNameHint, _nameController),
                const SizedBox(height: 16),
                _sectionTitle(l10n.fundingRegisterLinkLabel),
                const SizedBox(height: 8),
                _textField(l10n.fundingRegisterLinkHint, _linkController),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(
            buttonText: l10n.fundingRegisterButton,
            pressedFunc: _isSubmitting ? null : submit,
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

  Widget _textField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.grey[400],
        ),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
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
              ? const Center(child: Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 40))
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _thumbnailImageFile!,
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
}
