import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/default_image.dart';
import 'package:on_woori/data/client/fundings_api_client.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/client/stores_api_client.dart';
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
  late Future<(ProductsResponse, FundingsResponse, StoresResponse)>
  _apiDataFuture;

  @override
  void initState() {
    super.initState();
    _apiDataFuture = _initializeData();
  }

  Future<(ProductsResponse, FundingsResponse, StoresResponse)>
  _initializeData() async {
    try {
      final productsResponse = await ProductsApiClient().products();
      debugPrint(
        "[파싱 성공] Product 엔티티 변환 완료. (아이템 수: ${productsResponse.data?.items?.length ?? 0})",
      );

      final fundingsResponse = await FundingsApiClient().fundings();
      debugPrint(
        "[파싱 성공] Funding 엔티티 변환 완료. (아이템 수: ${fundingsResponse.data?.items.length ?? 0})",
      );

      final storesResponse = await StoresApiClient().stores();
      debugPrint(
        "[파싱 성공] Store 엔티티 변환 완료. (아이템 수: ${storesResponse.data?.items.length ?? 0})",
      );

      debugPrint("모든 엔티티 파싱 성공");
      return (productsResponse, fundingsResponse, storesResponse);
    } catch (e, s) {
      debugPrint("오류 내용: $e");
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.appTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: FutureBuilder<(ProductsResponse, FundingsResponse, StoresResponse)>(
        future: _apiDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(l10n.homePageError('${snapshot.error}')));
          }

          if (!snapshot.hasData) {
            return Center(child: Text(l10n.homePageNoData));
          }

          final productItems =
          (snapshot.data?.$1.data?.items ?? []).take(4).toList();
          final fundingItems =
          (snapshot.data?.$2.data?.items ?? []).toList();
          final storeItems =
          (snapshot.data?.$3.data?.items ?? []).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2.5 / 1,
                  child: Image.network(
                    fit: BoxFit.cover,
                    DefaultImage.bannerThumbnail,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSectionHeader(title: l10n.homeRecommendedProducts),
                const SizedBox(height: 12),
                ProductsNonScrollableGrid(productItems.take(4).toList()),
                const SizedBox(height: 12),
                _buildSectionHeader(title: l10n.homeOngoingFunding),
                SizedBox(
                  height: 230,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: fundingItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 0,
                      childAspectRatio: 0.23,
                    ),
                    itemBuilder: (context, index) {
                      final item = fundingItems[index];
                      return FundingListItem(
                        id: item.id,
                        imageUrl: item.thumbnailImageUrl ?? l10n.dummyImage,
                        fundingName: item.title,
                        brandName: item.companyId?.name ?? l10n.homePageNoBrand,
                        description: item.description ?? item.linkUrl ?? '',
                        linkUrl: item.linkUrl ?? '',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                _buildSectionHeader(title: l10n.homeBrandList),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 185, // 한 줄당 약 120씩 여유 잡기
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: storeItems.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final brand = storeItems[index];
                          return BrandGridItem(
                            imageUrl: brand.thumbnailImageUrl ?? DefaultImage.brandThumbnail,
                            brandName: brand.name,
                            onTap: () {
                              debugPrint('${brand.name} 클릭됨, ID: ${brand.id}');
                              context.push('/branddetail/${brand.id}');
                            },
                          );
                        },
                      ),
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //   const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 4,
                    //     crossAxisSpacing: 12,
                    //     childAspectRatio: 0.8,
                    //   ),
                    //   itemCount: storeItems.length,
                    //   itemBuilder: (context, index) {
                    //     final brand = storeItems[index];
                    //     return BrandGridItem(
                    //       imageUrl:
                    //       brand.thumbnailImageUrl ?? DefaultImage.brandThumbnail,
                    //       brandName: brand.name,
                    //       onTap: () {
                    //         debugPrint('${brand.name} 클릭됨, ID: ${brand.id}');
                    //         context.push('/branddetail/${brand.id}');
                    //       },
                    //     );
                    //   },
                    // ),
                    const SizedBox(height: 20),
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
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
