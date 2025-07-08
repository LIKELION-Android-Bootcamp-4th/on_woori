import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/client/mypage_api_client.dart';
import 'package:on_woori/data/entity/response/mypage/mypage_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String? userName;
  final apiClient = MypageApiClient();
  late Future<BuyerProfileResponse> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = apiClient.getBuyerProfile();
  }

  // Future<void> fetchUserProfile() async {
  //   final dio = Dio(
  //     BaseOptions(
  //       baseUrl: 'http://git.hansul.kr:3000',
  //       headers: {
  //         'Authorization':
  //         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODY3YzI3YzI0MTBiYmVlMTY4MDFkZDUiLCJjb21wYW55SWQiOiI2ODVmNjlmYzQzOTkyMmMwOWMyMWFlZjAiLCJpc0FkbWluIjp0cnVlLCJpc1N1cGVyQWRtaW4iOnRydWUsImlhdCI6MTc1MTg2Njg0MiwiZXhwIjoxNzUxOTUzMjQyfQ.404gq3LD9UicXvToI6FYQUcxSN4VQemYW9IAMbljO40',
  //         'X-Company-Code': '6866fd115b230f5dc709bdef',
  //       },
  //     ),
  //   );
  //
  //   try {
  //     final response = await dio.get('/api/mypage/profile');
  //     setState(() {
  //       userName = response.data['data']['name'];
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       userName = '정보 없음';
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}'));
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
                            child: Image.asset(
                              'assets/default_profile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),
                        Text(
                          snapshot.data?.data.name ?? '사용자',
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
                        context.push('/mypage/edit-buyer');
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
                    context.push('/mypage/password');
                  },
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