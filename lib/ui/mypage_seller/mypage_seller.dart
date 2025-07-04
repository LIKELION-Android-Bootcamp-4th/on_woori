import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class SellerMyPage extends StatelessWidget {
  const SellerMyPage({super.key});

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
        padding: const EdgeInsets.all(16.0),
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
                        color: Colors.pink[50],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Colors.pink),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '(주)멋쟁이 사자처럼',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '신서진 담당자님',
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

            const SizedBox(height: 16),

            // 쇼핑 섹션 라벨
            const Text(
              '쇼핑',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.grey,
              ),
            ),

            const SizedBox(height: 12),

            // 주문 내역
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '주문 내역',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.black),
              onTap: () {},
            ),

            // Divider
            const Divider(
              color: AppColors.DividerTextBoxLineDivider,
              thickness: 1,
              height: 16,
            ),

            // 마이페이지 섹션 라벨
            const Text(
              '마이페이지',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.grey,
              ),
            ),

            const SizedBox(height: 12),

            // 프로필 수정
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '프로필 수정',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.black),
              onTap: () {},
            ),

            // 비밀번호 변경
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '비밀번호 변경',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.black),
              onTap: () {
                context.go('/mypage/password');
              },
            ),

            // 상품 등록
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '상품 등록',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.black),
              onTap: () {
                context.go('/mypage/register');
              },
            ),

            // 펀딩 등록
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '펀딩 등록',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.black),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.black),
              onTap: () {
                context.push('/brand/editproduct');
              },
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
}
