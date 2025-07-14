import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_woori/data/client/seller_fundings_api_client.dart';
import 'package:on_woori/data/client/seller_store_api.dart';
import 'package:on_woori/data/entity/response/upload/upload_files_response.dart';
import '../../core/styles/app_colors.dart';
import '../../data/client/upload_api_client.dart';
import '../../data/entity/request/upload/upload_files_request.dart';
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
  File? _profileImageFile;
  String? _profileImageUrl;
  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) {
      print('이미 이미지 선택 중입니다.');
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
                    _profileImageFile = picked != null ? File(picked.path) : _profileImageFile;
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
                    _profileImageFile = picked != null ? File(picked.path) : _profileImageFile;
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

  Future<String?> getStoreId() async {
    try {
      final storeApiClient = SellerStoreApi();
      final response = await storeApiClient.getStore();

      print("storemessage : ${response.message}");

      if (response.success) {
        final storeId = response.data?.owner?.id;
        return storeId;
      } else {
        print('스토어 정보 불러오기 실패: ${response.message}');
        return null;
      }
    } catch (e) {
      print('스토어 ID 조회 중 오류 발생: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void submit() async {
    final storeId = await getStoreId();
    if (storeId != null) {
      String? imageUrl = _profileImageUrl;

      // 이미지 선택된 경우 업로드
      if (_profileImageFile != null) {
        try {
          final uploadClient = UploadApiClient();
          final request = UploadFilesRequest(files: [XFile(_profileImageFile!.path)]);
          final UploadFilesResponse uploadResponse = await uploadClient.uploadFiles(request);

          if (uploadResponse.success && uploadResponse.data!.files.first.url.isNotEmpty) {
            imageUrl = uploadResponse.data?.files.first.url;
            print('업로드된 이미지 URL: $imageUrl');
          } else {
            print('파일 업로드 실패 또는 URL 없음');
            return;
          }
        } catch (e) {
          print('이미지 업로드 중 오류 발생: $e');
          return;
        }
      }
      final res = await fundingApiClient.createFunding(
        storeId: storeId,
        title: _nameController.text,
        linkUrl: _linkController.text,
        imageUrl: imageUrl,
      );
      print("storeId: $storeId");

      setState(() {
        if (res.success) {
          print('펀딩 생성 성공!');
          // 추가로 생성된 펀딩 목록 갱신 등 작업
        } else {
          print('생성 실패: ${res.message}');
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '신규 펀딩 등록',
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
            Center(child: _sectionTitle('대표 이미지')),
            const SizedBox(height: 8),
            Center(child: _imageBox()),

            const SizedBox(height: 24),
            _sectionTitle('펀딩명'),
            const SizedBox(height: 8),
            _textField('(이름)', _nameController),

            const SizedBox(height: 16),
            _sectionTitle('펀딩 링크'),
            const SizedBox(height: 8),
            _textField('https://www.', _linkController),

            const SizedBox(height: 16),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(buttonText: '펀딩 추가', pressedFunc: submit),
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
          borderSide: BorderSide(color: AppColors.DividerTextBoxLineDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.DividerTextBoxLineDivider),
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
          child: _profileImageFile == null
              ? const SizedBox.shrink()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _profileImageFile!,
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
