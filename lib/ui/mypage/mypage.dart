import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _storage = const FlutterSecureStorage();
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = await _storage.read(key: 'ACCESS_TOKEN');
      final companyCode = await _storage.read(key: 'COMPANY_CODE');

      if (token == null || companyCode == null) {
        throw Exception('토큰이나 회사 코드가 없음');
      }

      final dio = Dio(
        BaseOptions(
          baseUrl: 'http://git.hansul.kr:3000',
          headers: {
            'Authorization': 'Bearer $token',
            'X-Company-Code': companyCode,
          },
        ),
      );

      final response = await dio.get('/api/mypage/profile');
      setState(() {
        userName = response.data['data']['name'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        userName = '정보 없음';
        isLoading = false;
      });
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/wish/cart');
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserInfoRow(isLoading: isLoading, userName: userName),
            const SizedBox(height: 20),
            const _SectionLabel(label: '쇼핑'),
            const SizedBox(height: 10),
            _LinkTile(label: '주문 내역', route: '/orderlist'),
            _LinkTile(label: '위시리스트', route: '/wish'),
            const Divider(
              color: AppColors.DividerTextBoxLineDivider,
              thickness: 1,
              height: 20,
            ),
            const SizedBox(height: 10),
            const _SectionLabel(label: '내 정보'),
            const SizedBox(height: 10),
            _LinkTile(label: '비밀번호 변경', route: '/mypage/password'),
            const Divider(
              color: AppColors.DividerTextBoxLineDivider,
              thickness: 1,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  final bool isLoading;
  final String? userName;

  const _UserInfoRow({
    required this.isLoading,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            ClipOval(
              child: SizedBox(
                width: 48,
                height: 48,
                child: Image.asset(
                  'assets/default_profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isLoading ? '로딩 중...' : (userName ?? '사용자'),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              '고객님',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: const BorderSide(
                color: AppColors.grey,
              ),
            ),
          ),
          onPressed: () {
            context.push('/mypage/edit');
          },
          child: const Text(
            '프로필 수정',
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
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.grey,
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final String label;
  final String route;

  const _LinkTile({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
      onTap: () {
        context.push(route);
      },
    );
  }
}
