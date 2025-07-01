import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          l10n.bottomNavigationBarMyPage,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: 장바구니 페이지 이동
            },
            icon: Image.asset(
              "images/icon/cart.png",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  children: const [
                    Text(
                      '안현진',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
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
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: const BorderSide(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // TODO: 프로필 수정 이동
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

            // 위시리스트
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                '위시리스트',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.black),
              onTap: () {},
            ),

            // Divider between 위시리스트 and 내 정보
            const Divider(
              color: AppColors.DividerTextBoxLineDivider,
              thickness: 1,
              height: 16,
            ),

            // 내 정보 섹션 라벨
            const Text(
              '내 정보',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.grey,
              ),
            ),

            const SizedBox(height: 12),

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
              onTap: () {},
            ),

            // Divider under 비밀번호 변경
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