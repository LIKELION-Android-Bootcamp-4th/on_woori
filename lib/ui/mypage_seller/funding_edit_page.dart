import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_woori/data/client/fundings_api_client.dart';
import 'package:on_woori/data/client/seller_fundings_api_client.dart';
import '../../core/styles/app_colors.dart';
import '../../widgets/bottom_button.dart';

class FundingEditPage extends StatefulWidget {
  final String fundingId;

  const FundingEditPage({
    super.key,
    required this.fundingId,
  });

  @override
  State<FundingEditPage> createState() => _FundingEditPageState();
}

class _FundingEditPageState extends State<FundingEditPage> {
  final _nameController = TextEditingController();
  final _linkController = TextEditingController();
  final _fundingApiClient = FundingsApiClient();
  final _fundingEditApiClient = SellerFundingsApiClient();

  File? _profileImageFile;
  String? _profileImageUrl;
  bool _isPickingImage = false;
  bool _isLoading = true; // ◀️ 1. 로딩 상태 관리를 위한 변수

  @override
  void initState() {
    super.initState();
    _fetchFundingDetails();
  }

  // ◀️ 2. 펀딩 상세 정보 조회 함수
  Future<void> _fetchFundingDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 수정된 API 클라이언트 호출
      final response = await _fundingApiClient.fundingDetail(id: widget.fundingId);

      // API 응답의 success 필드와 data 존재 여부 확인
      if (response.success && response.data != null) {
        // 💥 더 이상 .items.first 로 접근하지 않음
        final fundingItem = response.data!;

        setState(() {
          _nameController.text = fundingItem.title;
          _linkController.text = fundingItem.linkUrl ?? '';
          _profileImageUrl = fundingItem.imageUrl;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('펀딩 정보를 불러오는데 실패했습니다: ${response.message}')),
          );
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다: $e')),
        );
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  Future<void> _pickImage() async {
    // ... (기존과 동일)
    if (_isPickingImage) return;

    setState(() { _isPickingImage = true; });

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
                  final XFile? picked = await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
                  if (!mounted) return;
                  setState(() {
                    if (picked != null) {
                      _profileImageFile = File(picked.path);
                      _profileImageUrl = null;
                    }
                    _isPickingImage = false;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
                  if (!mounted) return;
                  setState(() {
                    if (picked != null) {
                      _profileImageFile = File(picked.path);
                      _profileImageUrl = null;
                    }
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
        setState(() { _isPickingImage = false; });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  // 🔽 펀딩 수정 로직 수정
  void updateFunding() async {

    try {
      final res = await _fundingEditApiClient.editFundings(
        id: widget.fundingId,
        title: _nameController.text,
        linkUrl: _linkController.text,
        thumbnailImage: _profileImageFile,
      );

      if (mounted) {
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('펀딩 정보가 성공적으로 수정되었습니다.')),
          );
          context.pop(true);
        } else {
          final errorMessage = (res.data is Map<String, dynamic>)
              ? res.data['message'] ?? '알 수 없는 오류가 발생했습니다.'
              : res.statusMessage ?? '펀딩 수정에 실패했습니다.';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('펀딩 수정에 실패했습니다: $errorMessage')),
          );
        }
      }
    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '펀딩 수정',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      // ◀️ 3. 로딩 상태에 따라 UI 분기 처리
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
      bottomNavigationBar: _isLoading
          ? null // 로딩 중일때는 하단 버튼 숨기기
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(
            buttonText: '펀딩 수정',
            pressedFunc: updateFunding,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black));
  }

  Widget _textField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey[400]),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.DividerTextBoxLineDivider)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.DividerTextBoxLineDivider)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
            image: _profileImageFile == null && (_profileImageUrl == null || _profileImageUrl!.isEmpty)
                ? null
                : DecorationImage(
              image: _profileImageFile != null ? FileImage(_profileImageFile!) as ImageProvider : NetworkImage(_profileImageUrl!),
              fit: BoxFit.cover,
            ),
          ),
          child: (_profileImageFile == null && (_profileImageUrl == null || _profileImageUrl!.isEmpty))
              ? const Center(child: Icon(Icons.photo, color: Colors.grey, size: 50))
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
              child: const SizedBox(width: 44, height: 44, child: Icon(Icons.add, color: Colors.black, size: 24)),
            ),
          ),
        ),
      ],
    );
  }
}