import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/stores_api_client.dart';
import 'package:on_woori/data/entity/response/stores/stores_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import '../../widgets/bottom_button.dart';

class BrandEditPage extends StatefulWidget {
  const BrandEditPage({super.key});

  @override
  State<BrandEditPage> createState() => _BrandEditPageState();
}

class _BrandEditPageState extends State<BrandEditPage> {
  final _nameController = TextEditingController();
  final _introController = TextEditingController();
  File? _profileImageFile;
  String? _profileImageUrl;

  bool _isPickingImage = false;

  late Future<SellerStoreResponse> _brandFuture;
  final apiClient = StoresApiClient();

  @override
  void initState() {
    super.initState();
    _brandFuture = apiClient.getSellerStore().then((value) {
      if (mounted) {
        setState(() {
          _profileImageUrl = value.data.thumbnailImageUrl;
        });
      }
      return value;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _introController.dispose();
    super.dispose();
  }

  Future<void> _onAddImagePressed() async {
    final l10n = AppLocalizations.of(context)!;
    if (_isPickingImage) {
      debugPrint(l10n.brandEditImagePicking);
      return;
    }

    setState(() {
      _isPickingImage = true;
    });

    final ImagePicker picker = ImagePicker();

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
                title: Text(l10n.brandEditCamera),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? picked = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 85,
                  );
                  if (!mounted) return;
                  setState(() {
                    _profileImageFile =
                    picked != null ? File(picked.path) : _profileImageFile;
                    _profileImageUrl = picked != null ? null : _profileImageUrl;
                    _isPickingImage = false;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.brandEditGallery),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? picked = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 85,
                  );
                  if (!mounted) return;
                  setState(() {
                    _profileImageFile =
                    picked != null ? File(picked.path) : _profileImageFile;
                    _profileImageUrl = picked != null ? null : _profileImageUrl;
                    _isPickingImage = false;
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

  Future<void> _submit(SellerStoreData data) async {
    final l10n = AppLocalizations.of(context)!;
    final String? imagePath = _profileImageFile?.path;
    MultipartFile? multipartFile;
    if (imagePath != null && imagePath.isNotEmpty) {
      multipartFile = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );
    }

    if (_nameController.text.isEmpty) _nameController.text = data.name;
    if (_introController.text.isEmpty) {
      _introController.text = data.description ?? "";
    }

    try {
      await apiClient.editSellerStore(
        name: _nameController.text,
        description: _introController.text,
        data: data,
        image: multipartFile,
      );
    } catch (e, s) {
      debugPrint('수정 실패 $e');
      debugPrint(s.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.brandEditUpdateFailed(e.toString()))),
        );
      }
    }

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FutureBuilder<SellerStoreResponse>(
      future: _brandFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text(l10n.brandEditFetchError('${snapshot.error}'))));
        }

        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: Text(l10n.brandEditNoData)));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.brandEditPageTitle,
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Center(child: _circleImageBox()),
                const SizedBox(height: 24),
                _sectionTitle(l10n.brandEditNameLabel),
                const SizedBox(height: 8),
                _textField(
                    snapshot.data?.data.name ?? l10n.brandEditNameHint,
                    _nameController),
                const SizedBox(height: 16),
                _sectionTitle(l10n.brandEditDescriptionLabel),
                const SizedBox(height: 8),
                _textField(
                  snapshot.data?.data.description ??
                      l10n.brandEditDescriptionHint,
                  _introController,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BottomButton(
                buttonText: l10n.brandEditSaveButton,
                pressedFunc: () {
                  if (snapshot.data?.data != null) {
                    _submit(snapshot.data!.data);
                  }
                },
              ),
            ),
          ),
        );
      },
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
          borderSide:
          const BorderSide(color: AppColors.dividerTextBoxLineDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          const BorderSide(color: AppColors.dividerTextBoxLineDivider),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
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
          decoration: const BoxDecoration(
            color: AppColors.optionStateList,
            shape: BoxShape.circle,
          ),
          child: _profileImageFile == null
              ? (_profileImageUrl == null
              ? const SizedBox.shrink()
              : ClipOval(
            child: Image.network(
              _profileImageUrl!,
              fit: BoxFit.cover,
              height: 120,
              width: 120,
            ),
          ))
              : ClipOval(
            child: Image.file(
              _profileImageFile!,
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
              child: const SizedBox(
                width: 33,
                height: 33,
                child: Icon(Icons.add, color: Colors.black, size: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
