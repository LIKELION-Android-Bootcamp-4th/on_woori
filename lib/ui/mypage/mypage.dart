import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/mypage_api_client.dart';
import 'package:on_woori/data/entity/response/mypage/profile_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<ProfileResponse> _apiDataFuture;

  @override
  void initState() {
    super.initState();
    _apiDataFuture = fetchUserProfile();
  }

  Future<ProfileResponse> fetchUserProfile() async {
    try {
      final profileResponse = await MypageApiClient().getProfile();
      return profileResponse;
    } catch (e, s) {
      debugPrint("프로필 조회 오류: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
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
            onPressed: () => context.push('/wish/cart'),
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: FutureBuilder<ProfileResponse>(
        future: _apiDataFuture,
        builder: (context, snapshot) {
          final bool isLoading = snapshot.connectionState == ConnectionState.waiting;
          String? userName;
          String? userImage;

          if (snapshot.hasError) {
            userName = "정보 로딩 실패";
          } else if (snapshot.hasData) {
            final profileData = snapshot.data?.data;
            userName = profileData?.nickName ?? profileData?.profile?.name ?? '사용자';
            userImage = profileData?.profileImage ?? profileData?.profile?.profileImage;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UserInfoRow(
                  isLoading: isLoading,
                  userName: userName,
                  imageUrl: userImage,
                ),
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
          );
        },
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  final bool isLoading;
  final String? userName;
  final String? imageUrl;

  const _UserInfoRow({
    required this.isLoading,
    this.userName,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const defaultAssetImage = 'assets/default_profile.png';
    final hasNetworkImage = imageUrl != null && imageUrl!.isNotEmpty;

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
                child: hasNetworkImage
                    ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(defaultAssetImage, fit: BoxFit.cover);
                  },
                )
                    : Image.asset(defaultAssetImage, fit: BoxFit.cover),
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
              '님',
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
              side: const BorderSide(color: AppColors.grey),
            ),
          ),
          onPressed: () => context.push('/mypage/edit'),
          child: const Text('프로필 수정', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Colors.black)),
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