import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/mypage_api_client.dart';
import 'package:on_woori/l10n/app_localizations.dart';

import '../../data/client/auth_api_client.dart';
import '../../data/entity/response/auth/logout_response.dart';
import '../../data/entity/response/mypage/mypage_response.dart';

class SellerMyPage extends StatefulWidget {
  @override
  State<SellerMyPage> createState() => _SellerMyPageState();
}

class _SellerMyPageState extends State<SellerMyPage> {
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
    final authClient = AuthApiClient();

    try {
      final LogoutResponse response = await authClient.authLogout();

      if (response.success) {
        // 토큰 삭제
        await _secureStorage.delete(key: 'ACCESS_TOKEN');
        await _secureStorage.delete(key: 'REFRESH_TOKEN');

        // 로그인 화면으로 이동 (모든 이전 페이지 제거)
        context.go('/auth/login');
        Fluttertoast.showToast(msg: '로그아웃 되었습니다.');
      } else {
        print('로그아웃 실패 : ${response.message}');
      }
    } catch (e) {
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

                  /// 판매자 정보 Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Image.network(
                                  snapshot.data?.data?.profile.profileImage?.path ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data?.data?.nickName ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '판매자님',
                                style: TextStyle(
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
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(color: AppColors.grey),
                          ),
                        ),
                        onPressed: () {
                          context.push('/brand/edit');
                        },
                        child: Text(
                          '브랜드 수정',  // 여기는 l10n 키 없음
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 주문 섹션 라벨
                  const Text(
                    '주문',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 주문 내역
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
                    onTap: () {},
                  ),

                  // Divider
                  const Divider(
                    color: AppColors.DividerTextBoxLineDivider,
                    thickness: 1,
                    height: 20,
                  ),

                  // 마이페이지 섹션 라벨
                  const SizedBox(height: 10,),
                  const Text(
                    '마이페이지',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.grey,
                    ),
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
                    onTap: () async {
                      final result = await context.push('/mypage/edit-buyer/${snapshot.data?.data?.nickName ?? ""}');
                      if (result == true) {
                        _refresh();
                      }
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

                  // Divider
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
    );
  }
}