import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/core/styles/default_image.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final authClient = AuthApiClient();

    try {
      final LogoutResponse response = await authClient.authLogout();

      if (response.success) {
        await _secureStorage.delete(key: 'ACCESS_TOKEN');
        await _secureStorage.delete(key: 'REFRESH_TOKEN');

        if (mounted) {
          context.go('/auth/login');
        }
        Fluttertoast.showToast(msg: l10n.myPageLogoutSuccess);
      } else {
        final errorMessage = l10n.myPageLogoutFailed(response.message);
        debugPrint(errorMessage);
        Fluttertoast.showToast(msg: errorMessage);
      }
    } catch (e) {
      final errorMessage = l10n.myPageLogoutError(e.toString());
      debugPrint(errorMessage);
      Fluttertoast.showToast(msg: errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder<BuyerProfileResponse>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/auth/login');
            debugPrint('오류 발생: ${snapshot.error}');
          });
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text(l10n.myPageNoData));
        }

        final profileData = snapshot.data?.data;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              l10n.navBarMyPage,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.network(
                          profileData?.profile.profileImage?.path ??
                              DefaultImage.profileThumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              DefaultImage.profileThumbnail,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          profileData?.nickName ?? l10n.myPageDefaultUserName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.myPageUserSuffix,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: const BorderSide(color: AppColors.grey),
                        ),
                      ),
                      onPressed: () async {
                        await context.push(
                          '/mypage/edit-buyer/${profileData?.nickName}/${profileData?.profile.profileImage}',
                        );
                        _refresh();
                      },
                      child: Text(
                        l10n.myPageProfileEditButton,
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
                Text(
                  l10n.myPageSectionShopping,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    l10n.myPageOrderHistory,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.black,
                  ),
                  onTap: () {
                    context.push('/orderlist');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    l10n.myPageWishlist,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.black,
                  ),
                  onTap: () {
                    context.push('/wish');
                  },
                ),
                const Divider(
                  color: AppColors.dividerTextBoxLineDivider,
                  thickness: 1,
                  height: 20,
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.myPageSectionMyInfo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    l10n.myPageChangePassword,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.black,
                  ),
                  onTap: () {
                    context.push('/mypage/password/${profileData?.id}');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    l10n.myPageLogout,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.black,
                  ),
                  onTap: () => _handleLogout(context),
                ),
                const Divider(
                  color: AppColors.dividerTextBoxLineDivider,
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
