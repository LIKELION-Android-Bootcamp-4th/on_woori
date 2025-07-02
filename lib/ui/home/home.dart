import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/entity/request/auth/login_request.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/funding_list_item.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ProductsResponse> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _initializeData();
  }

  Future<ProductsResponse> _initializeData() async {
    await _loginAndSaveToken();
    final apiClient = ProductsApiClient();
    return apiClient.products();
  }

  Future<void> _loginAndSaveToken() async {
    print("로그인 테스트 시작");
    final apiClient = AuthApiClient();
    final storage = const FlutterSecureStorage();
    try {
      final response = await apiClient.authLogin(
        request: LoginRequest(
          email: 'admin@git.hansul.kr',
          password: 'qwer1234!@#\$',
        ),
      );
      await storage.write(key: 'ACCESS_TOKEN', value: response.data.accessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: response.data.refreshToken);
    } catch (e) {
      print('로그인 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> dummyFundingItems = [
      {
        'imageUrl': 'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
        'fundingName': '한산모시 쿨링 셔츠',
        'brandName': '모시메리',
        'description': '여름을 시원하게! 전통 한산모시로 만든 현대적인 셔츠입니다.',
      },
      {
        'imageUrl': 'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
        'fundingName': '자개 무선충전패드',
        'brandName': '나전공방',
        'description': '전통 나전칠기 기법으로 만든 IT 기기. 당신의 책상을 빛내줄 단 하나의 아이템.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: FutureBuilder<ProductsResponse>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'));
          }

          final productItems = snapshot.data?.data?.items ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2.5 / 1,
                  child: Container(color: Colors.grey[300], child: const Center(child: Text('배너'))),
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
                      crossAxisCount: 2, childAspectRatio: 0.6, crossAxisSpacing: 12, mainAxisSpacing: 20,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final product = productItems[index];
                      return ProductsGridItem(product);
                    },
                  ),
                ),
                const SizedBox(height: 32),

                _buildSectionHeader(title: "진행중인 펀딩"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dummyFundingItems.length,
                  itemBuilder: (context, index) {
                    final item = dummyFundingItems[index];
                    return FundingListItem(
                      imageUrl: item['imageUrl']!,
                      fundingName: item['fundingName']!,
                      brandName: item['brandName']!,
                      description: item['description']!,
                    );
                  },
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