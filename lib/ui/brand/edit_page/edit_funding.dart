import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_woori/data/client/fundings_api_client.dart';
import 'package:on_woori/data/client/seller_fundings_api_client.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import '../../../core/styles/app_colors.dart';
import '../../../widgets/bottom_button.dart';

class FundingEditPage extends StatefulWidget {
  final String fundingId;

  const FundingEditPage({super.key, required this.fundingId});

  @override
  State<FundingEditPage> createState() => _FundingEditPageState();
}

class _FundingEditPageState extends State<FundingEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final _fundingApiClient = FundingsApiClient();
  final _fundingEditApiClient = SellerFundingsApiClient();

  File? _thumbnailImageFile;
  String? _thumbnailImageUrl;
  bool _isPickingImage = false;
  bool _isLoading = true;
  bool _isSubmitting = false;
  bool _isImageRemoved = false;

  @override
  void initState() {
    super.initState();
    _fetchFundingDetails();
  }

  Future<void> _fetchFundingDetails() async {
    setState(() => _isLoading = true);
    try {
      final response = await _fundingApiClient.fundingDetail(id: widget.fundingId);
      if (mounted && response.success && response.data != null) {
        final item = response.data!;
        setState(() {
          _nameController.text = item.title;
          _linkController.text = item.linkUrl ?? '';
          _thumbnailImageUrl = item.thumbnailImageUrl;
        });
      } else {
        if (mounted) {
          _showSnackBar('펀딩 정보를 불러오는데 실패했습니다: ${response.message}');
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('오류가 발생했습니다: $e');
        context.pop();
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    setState(() => _isPickingImage = true);

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
                  final picked = await picker.pickImage(source: ImageSource.camera);
                  if (mounted && picked != null) {
                    setState(() {
                      _thumbnailImageFile = File(picked.path);
                      _thumbnailImageUrl = null;
                      _isImageRemoved = false;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.fundingRegisterGallery),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await picker.pickImage(source: ImageSource.gallery);
                  if (mounted && picked != null) {
                    setState(() {
                      _thumbnailImageFile = File(picked.path);
                      _thumbnailImageUrl = null;
                      _isImageRemoved = false;
                    });
                  }
                },
              ),
              if (_thumbnailImageUrl != null || _thumbnailImageFile != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text('이미지 삭제', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _thumbnailImageFile = null;
                      _thumbnailImageUrl = null;
                      _isImageRemoved = true;
                    });
                  },
                ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      if (mounted) setState(() => _isPickingImage = false);
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

  void _updateFunding() async {
    final l10n = AppLocalizations.of(context)!;

    if (_nameController.text.isEmpty || _linkController.text.isEmpty) {
      _showSnackBar(l10n.validatorRequired);
      return;
    }

    final urlPattern = r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$';
    final urlRegExp = RegExp(urlPattern, caseSensitive: false);
    if (!urlRegExp.hasMatch(_linkController.text)) {
      _showSnackBar(l10n.validatorUrlInvalid);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final res = await _fundingEditApiClient.editFundings(
        id: widget.fundingId,
        title: _nameController.text,
        linkUrl: _linkController.text,
        thumbnailImage: _thumbnailImageFile,
        deleteThumbnail: _isImageRemoved,
      );

      if (mounted) {
        if (res.statusCode == 200) {
          _showSnackBar('펀딩 정보가 성공적으로 수정되었습니다.', isError: false);
          context.pop(true);
        } else {
          final errorMessage = (res.data is Map<String, dynamic>)
              ? res.data['message'] ?? '알 수 없는 오류가 발생했습니다.'
              : res.statusMessage ?? '펀딩 수정에 실패했습니다.';
          _showSnackBar('수정 실패: $errorMessage');
        }
      }
    } catch (e) {
      if (mounted) _showSnackBar('오류가 발생했습니다: $e');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '펀딩 수정',
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                _textField(
                  l10n.fundingRegisterLinkHint,
                  _linkController,
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      bottomNavigationBar: _isLoading
          ? null
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(
            buttonText: '펀딩 수정',
            pressedFunc: _isSubmitting ? null : _updateFunding,
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
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _textField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
    ImageProvider? imageProvider;
    if (_thumbnailImageFile != null) {
      imageProvider = FileImage(_thumbnailImageFile!);
    } else if (_thumbnailImageUrl != null && _thumbnailImageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(_thumbnailImageUrl!);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.optionStateList,
            borderRadius: BorderRadius.circular(12),
            image: imageProvider != null
                ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                : null,
          ),
          child: imageProvider == null
              ? const Center(
              child: Icon(Icons.camera_alt_outlined,
                  color: Colors.grey, size: 40))
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
