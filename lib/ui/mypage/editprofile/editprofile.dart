import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/mypage_api_client.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_response.dart';
import 'package:on_woori/widgets/bottom_button.dart';

class EditProfilePage extends StatefulWidget {
  String nickName;
  String profileUrl;

  EditProfilePage({
    super.key,
    required this.nickName,
    required this.profileUrl,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailAddressController =
      TextEditingController();

  File? _profileImageFile;
  String? _profileImageUrl;

  bool _isPickingImage = false;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneController.dispose();
    _zipcodeController.dispose();
    _addressController.dispose();
    _detailAddressController.dispose();
    super.dispose();
  }

  void _fetchProfile() {
    setState(() {
      _nicknameController.text = widget.nickName;
      _phoneController.text = '';
      _zipcodeController.text = '';
      _addressController.text = '';
      _detailAddressController.text = '';
      _profileImageUrl = widget.profileUrl;
    });
  }

  Future<void> _pickImage() async {
    if (_isPickingImage) {
      debugPrint('이미 이미지 선택 중입니다.');
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
                title: const Text('카메라로 촬영'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? picked = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 85,
                  );
                  if (!mounted) return;
                  setState(() {
                    _profileImageFile = picked != null
                        ? File(picked.path)
                        : _profileImageFile;
                    _profileImageUrl = picked != null ? null : _profileImageUrl;
                    _isPickingImage = false;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? picked = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 85,
                  );
                  if (!mounted) return;
                  setState(() {
                    _profileImageFile = picked != null
                        ? File(picked.path)
                        : _profileImageFile;
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
      // BottomSheet 닫힐 때 플래그 해제
      if (mounted) {
        setState(() {
          _isPickingImage = false;
        });
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final apiClient = MypageApiClient();

    final String? imagePath = _profileImageFile?.path;
    MultipartFile? multipartFile;
    if (imagePath != null && imagePath.isNotEmpty) {
      multipartFile = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );
    }
    try {
      final response = await apiClient.editBuyerProfile(
        nickName: _nicknameController.text,
        phone: _phoneController.text,
        address: AddressData(
          zipCode: _zipcodeController.text,
          address1: _addressController.text,
          address2: _detailAddressController.text,
        ),
        profileImageFile: multipartFile,
      );
      debugPrint('닉네임: ${response.data.nickName}');
      debugPrint('전화번호: ${response.data.phone}');
    } catch (e, s) {
      debugPrint('수정 실패 $e');
      debugPrint(s.toString());
    }

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.categoryContainer,
                      backgroundImage: _profileImageFile != null
                          ? FileImage(_profileImageFile!)
                          : (_profileImageUrl != null
                                    ? NetworkImage(_profileImageUrl!)
                                    : null)
                                as ImageProvider?,
                      child:
                          (_profileImageFile == null &&
                              _profileImageUrl == null)
                          ? const Icon(
                              Icons.person,
                              size: 48,
                              color: AppColors.grey,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primarySub,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildLabel('닉네임'),
              const SizedBox(height: 5),
              _buildTextFormField(
                _nicknameController,
                validatorText: '닉네임을 입력해주세요',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(buttonText: '저장', pressedFunc: _submit),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    String? validatorText,
    String? Function(String?)? validator,
  }) {
    return Column(
      children: [
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.dividerTextBoxLineDivider,
              ),
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
          ),
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return validatorText ?? '내용을 입력해주세요';
                }
                return null;
              },
        ),
      ],
    );
  }
}
