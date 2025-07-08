import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class SellerMyPage extends StatefulWidget {
  const SellerMyPage({super.key});

  @override
  State<SellerMyPage> createState() => _SellerMyPageState();
}

class _SellerMyPageState extends State<SellerMyPage> {
  final _storage = const FlutterSecureStorage();

  bool _isLoading = true;
  String? _companyName;
  String? _managerName;
  String? _profileImageUrl;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final token = await _storage.read(key: 'ACCESS_TOKEN');
      final companyCode = await _storage.read(key: 'COMPANY_CODE');

      if (token == null || companyCode == null) {
        throw Exception('토큰 또는 회사코드가 없습니다.');
      }

      final dio = Dio(
        BaseOptions(
          baseUrl: 'http://git.hansul.kr:3002',
          headers: {
            'Authorization': 'Bearer $token',
            'X-Company-Code': companyCode,
          },
        ),
      );

      final response = await dio.get('/api/mypage/profile');
      final data = response.data['data'];

      setState(() {
        _companyName = data['companyName'];
        _managerName = data['name'];
        _profileImageUrl = data['profileImage'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = '정보 없음';
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: '프로필 정보를 불러올 수 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.bottomNavigationBarMyPage,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileRow(),
            const SizedBox(height: 20),
            const SectionLabel(title: '주문'),
            const SizedBox(height: 10),
            _buildListTile('주문 내역', () {
              context.push('/orderlist');
            }),
            const Divider(
              color: AppColors.DividerTextBoxLineDivider,
              thickness: 1,
              height: 20,
            ),
            const SizedBox(height: 10),

            // 프로필 수정
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '프로필 수정',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
              onTap: () {
                context.push('/mypage/edit-seller');
              },
            ),

            // 비밀번호 변경
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '비밀번호 변경',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
              onTap: () {
                context.push('/mypage/password');
              },
            ),

            // 상품 등록
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '상품 등록',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
              onTap: () {
                context.push('/mypage/register');
              },
            ),

            // 펀딩 등록
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '펀딩 등록',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
              onTap: () {
                context.push('/funding/register');
              },
            ),


            // 등록 상품 / 펀딩 관리
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '등록 상품 / 펀딩 관리',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
              onTap: () {
                context.push('/brand/editproduct');
              },
            ),
            const Divider(
              color: AppColors.DividerTextBoxLineDivider,
              thickness: 1,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow() {
    String displayCompany = _isLoading
        ? '로딩 중...'
        : (_error != null ? '정보 없음' : (_companyName ?? '(이름 없음)'));

    String displayManager = _isLoading
        ? ''
        : (_error != null ? '정보없음 담당자님' : '${_managerName ?? ''} 담당자님');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 48,
                height: 48,
                child: _isLoading
                    ? Container(color: AppColors.categoryContainer)
                    : (_error != null || _profileImageUrl == null || _profileImageUrl!.isEmpty
                    ? Image.asset('assets/default_profile.png', fit: BoxFit.cover)
                    : Image.network(_profileImageUrl!, fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayCompany,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayManager,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(color: AppColors.grey),
            ),
          ),
          onPressed: () {
            context.push('/brand/edit');
          },
          child: const Text(
            '브랜드 수정',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
      onTap: onTap,
    );
  }
}

class SectionLabel extends StatelessWidget {
  final String title;

  const SectionLabel({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.grey,
      ),
    );
  }
}
