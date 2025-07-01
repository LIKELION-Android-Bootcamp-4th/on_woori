import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/entity/request/auth/login_request.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loginAndSaveToken();
  }

  Future<void> _loginAndSaveToken() async {
    print("로그인 테스트 코드");
    final apiClient = AuthApiClient();
    final storage = const FlutterSecureStorage();

    apiClient.authLogin(request:
    LoginRequest(
        email: 'admin@git.hansul.kr',
        password: 'qwer1234!@#\$'
    ))
        .then((response) {
      // 로그인 성공하면 바로 엑세스 토큰을 SecureStorage 에 저장합니다.
      storage.write(key: 'ACCESS_TOKEN', value: response.data.accessToken);
      storage.write(key: 'REFRESH_TOKEN', value: response.data.refreshToken);

    }).catchError((e) => print('로그인 실패: $e'))
        .whenComplete(() => print('테스트 종료'));

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final apiClient = ProductsApiClient();
    final response = apiClient.products();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.appTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
      ),
      body: FutureBuilder<ProductsResponse>(
        future: response,
        builder: (context, snapshot) {
          final productItems = snapshot.data?.data.items ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 배너 섹션
                AspectRatio(
                  aspectRatio: 2.5 / 1,
                  child: Container(
                    color: Colors.grey[300],
                    child: const Center(child: Text('배너')),
                  ),
                ),
                const SizedBox(height: 24),

                _buildSectionHeader(title: l10n.home_RecommendedProducts),
                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: productItems.length,
                    itemBuilder: (context, index) {
                      final product = productItems[index];
                      return ProductsGridItem(
                        product.name,
                        product.store?.name ?? '브랜드 없음',
                        product.images.main,
                        product.isFavorite,
                        price: product.price,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}