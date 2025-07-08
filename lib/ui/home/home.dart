import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/client/fundings_api_client.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/client/stores_api_client.dart';
import 'package:on_woori/data/entity/request/auth/login_request.dart';
import 'package:on_woori/data/entity/response/fundings/fundings_response.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/data/entity/response/stores/stores_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/brand_grid_item.dart';
import 'package:on_woori/widgets/funding_list_item.dart';
import 'package:on_woori/widgets/products_double_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<(ProductsResponse, FundingsResponse, StoresResponse)> _apiDataFuture;

  @override
  void initState() {
    super.initState();

    _apiDataFuture = _initializeData();
  }

  Future<(ProductsResponse, FundingsResponse, StoresResponse)> _initializeData() async {
    await _loginAndSaveToken();

    try {
      final productsResponse = await ProductsApiClient().products();
      print("[파싱 성공] Product 엔티티 변환 완료. (아이템 수: ${productsResponse.data?.items?.length ?? 0})");

      print(productsResponse.data?.items?[0].thumbnailImage);

      final fundingsResponse = await FundingsApiClient().fundings();
      print("[파싱 성공] Funding 엔티티 변환 완료. (아이템 수: ${fundingsResponse.data?.items.length ?? 0})");

      final storesResponse = await StoresApiClient().stores();
      print("[파싱 성공] Store 엔티티 변환 완료. (아이템 수: ${storesResponse.data?.length ?? 0})");


      print("모든 엔티티 파싱 성공");
      return (productsResponse, fundingsResponse, storesResponse);

    } catch (e, s) {
      print("오류 내용: $e");
      print(s);
      rethrow;
    }
  }

  Future<void> _loginAndSaveToken() async {
    print("로그인 테스트 시작");

    final apiClient = AuthApiClient();
    final storage = const FlutterSecureStorage();
    try {
      final response = await apiClient.authLogin(
        request: LoginRequest(
          email: 'admin@hanbokmall.com',
          password: 'qwer1234',
        ),
      );
      await storage.delete(key: 'ACCESS_TOKEN');
      await storage.write(key: 'ACCESS_TOKEN', value: response.data.accessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: response.data.refreshToken);
      await storage.write(key: 'COMPANY_CODE', value: '6866fd115b230f5dc709bdef');
      print(await storage.read(key: 'ACCESS_TOKEN'));
    } catch (e, s) {
      print('로그인 실패: $e');
      print(s);
    }
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: FutureBuilder<(ProductsResponse, FundingsResponse, StoresResponse)>(
        future: _apiDataFuture,
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

          final productItems = (snapshot.data?.$1.data?.items ?? []).take(4).toList();
          final fundingItems = (snapshot.data?.$2.data?.items ?? []).take(3).toList();
          final storeItems = (snapshot.data?.$3.data ?? []).take(8).toList();

          print(productItems[0].images);

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2.5 / 1,
                  child:

                  TextButton(
                      onPressed: () { context.push('/auth/login'); },
                      child: const Center(child: Text('배너')
                      )),
                ),

                const SizedBox(height: 24),

                _buildSectionHeader(title: l10n.home_RecommendedProducts),
                const SizedBox(height: 12),
                ProductsNonScrollableGrid(productItems.take(4).toList()),
                const SizedBox(height: 32),

                const SizedBox(height: 32),
                _buildSectionHeaderAndMore(title: l10n.home_OngoingFunding),
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: fundingItems.length,
                  itemBuilder: (context, index) {
                    final item = fundingItems[index];
                    return FundingListItem(
                      imageUrl: item.imageUrl ?? 'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
                      fundingName: item.title,
                      brandName: item.companyId?.name ?? '브랜드 없음',
                      description: item.description ?? item.linkUrl ?? '',
                      linkUrl: item.linkUrl ?? '',
                    );
                  },
                ),
                const SizedBox(height: 32),

                _buildSectionHeaderAndMore(title: l10n.home_BrandList),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: storeItems.length,
                      itemBuilder: (context, index) {
                        final brand = storeItems[index];
                        return BrandGridItem(
                          imageUrl: 'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
                          brandName: brand.name,
                          onTap: () {
                            print('${brand.name} 클릭됨, ID: ${brand.id}');
                            context.push('/branddetail/${brand.id}');
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionHeaderAndMore({required String title}) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: (){},
          child: Text(
            "더보기",
            style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
                decoration: TextDecoration.underline
            ),
          ),
        ),
      ],
    );
  }
}