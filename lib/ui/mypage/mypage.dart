import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/mypage_api_client.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';

import '../../data/client/auth_api_client.dart';
import '../../data/entity/response/auth/logout_response.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final apiClient = MypageApiClient();
  late Future<BuyerProfileResponse> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = apiClient.getBuyerProfile();
  }

  void _refresh() {
    setState(() {
      _profileFuture = apiClient.getBuyerProfile();
    });
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> _handleLogout(BuildContext context) async {
    try {
      await _secureStorage.deleteAll();
      // 로그인 화면으로 이동 (모든 이전 페이지 제거)
      if (mounted) {
        context.go('/auth/login');
        Fluttertoast.showToast(msg: '로그아웃 되었습니다.');
      }
    } catch (e) {
      await _secureStorage.deleteAll();
      if (mounted) {
        context.go('/auth/login');
        Fluttertoast.showToast(msg: '로그아웃 처리 중 오류가 발생했습니다.');
      }
      print('로그아웃 중 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/auth/login');
            print('오류 발생: ${snapshot.error}');
          });
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('데이터가 없습니다.'));
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              l10n.bottomNavigationBarMyPage, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            actions: [
              IconButton(
                onPressed: () {
                  context.push('/wish/cart');
                },
                icon: Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 사용자 정보 Row
                Row(
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
                            child: Image.network(
                              snapshot.data?.data?.profile.profileImage?.path ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, size: 30, color: Colors.grey);
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),
                        Text(
                          snapshot.data?.data?.nickName ?? '사용자',
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
                      onPressed: () async {
                        // 🔽 프로필 이미지 객체 대신 경로(path)를 전달하도록 수정
                        final result = await context.push('/mypage/edit-buyer/${snapshot.data?.data?.nickName ?? ""}/${snapshot.data?.data?.profile.profileImage?.path ?? ""}');
                        if (result == true) {
                          _refresh();
                        }
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
                ),

                const SizedBox(height: 20),

                const Text(
                  '쇼핑',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),

                const SizedBox(height: 10),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: const Text(
                    '주문 내역',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
                  onTap: () {
                    context.push('/orderlist');
                  },
                ),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: const Text(
                    '위시리스트',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
                  onTap: () {
                    context.push('/wish');
                  },
                ),

                const Divider(
                  color: AppColors.DividerTextBoxLineDivider,
                  thickness: 1,
                  height: 20,
                ),

                // 내 정보 섹션 라벨
                const SizedBox(height: 10,),
                const Text(
                  '내 정보',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),

                const SizedBox(height: 10),

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
                    context.push('/mypage/password:${snapshot.data?.data?.id}');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: const Text(
                    '로그아웃',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black),
                  onTap: () => _handleLogout(context),
                ),

                const Divider(
                  color: AppColors.DividerTextBoxLineDivider,
                  thickness: 1,
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
