import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/fundings_api_client.dart';
import 'package:on_woori/data/client/stores_api_client.dart';
import 'package:on_woori/data/entity/response/fundings/fundings_response.dart';
import 'package:on_woori/data/entity/response/stores/stores_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/category_horizontal_scroll.dart';
import 'package:on_woori/widgets/funding_list_item.dart';
import 'package:on_woori/widgets/products_double_grid.dart';
import 'package:on_woori/widgets/products_grid_item.dart';


class BrandDetailPage extends StatelessWidget {
  final String brandId;
  const BrandDetailPage(this.brandId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BrandDetailScreen(brandId),
              BrandProductScreen(brandId)
            ],
          ),
        )
    );
  }
}

class BrandDetailScreen extends StatefulWidget {
  final String id;
  const BrandDetailScreen(this.id, {super.key});

  @override
  State<StatefulWidget> createState() {
    return BrandDetailScreenState();
  }
}

class BrandDetailScreenState extends State<BrandDetailScreen> {
  final apiClient = StoresApiClient();
  // 상품 목록 관련 Future 제거
  late Future<StoreDetailResponse> _storesFuture;

  Future<StoreDetailResponse> _initializeData() async {
    return apiClient.storeDetail(widget.id);
  }

  @override
  void initState() {
    super.initState();
    _storesFuture = _initializeData();
    // 상품 목록 초기화 로직 제거
  }

  @override
  Widget build(BuildContext context) {
    final li0n = AppLocalizations.of(context);
    return FutureBuilder<StoreDetailResponse>(
      future: _storesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (snapshot.hasError) {
          return Center(child: Text("오류 발생: ${snapshot.error}"),);
        }

        if (!snapshot.hasData) {
          return const Center(child: Text("데이터가 없습니다."),);
        }

        final StoreDetailItem? data = snapshot.data?.data;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BrandNameSection(
                false,
                data?.name ?? "브랜드 이름",
                // Nullable 타입으로 변경됨에 따라 ?? "" 추가
                data?.thumbnailImageUrl ?? ""
            ),
            const SizedBox(height: 15,),
            Text(data?.description ?? "브랜드 소개",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                  fontSize: 13
              ),
            ),
            const SizedBox(height: 30,),
            const Divider(color: AppColors.DividerTextBoxLineDivider,),
            const SizedBox(height: 10,),
            Text(
              li0n!.home_RecommendedProducts,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10,),

            // 추천 상품 목록을 보여주던 FutureBuilder 제거
            // 이 UI는 BrandProductScreen으로 이동했습니다.
          ],
        );
      },
    );
  }
}

class BrandProductScreen extends StatefulWidget {
  final String id;
  const BrandProductScreen(this.id, {super.key});

  @override
  State<StatefulWidget> createState() {
    return BrandProductScreenState();
  }
}

class BrandProductScreenState extends State<BrandProductScreen> {
  final apiClient = StoresApiClient();
  late Future<StoreProductsResponse> _storesProductFuture;

  Future<StoreProductsResponse> _initializeProducts() async {
    try {
      return apiClient.storeProductList(widget.id);
    } catch (e, s) {
      print("오류 내용: $e");
      print("스택 트레이스: $s"); // 더 자세한 에러 로깅
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _storesProductFuture = _initializeProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreProductsResponse>(
      future: _storesProductFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 추천 상품 목록 높이만큼 로딩 인디케이터를 보여줍니다.
          return const SizedBox(
            height: 298,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          // 에러 발생 시 UI
          return const Center(child: Text("상품 정보를 가져오지 못했습니다."));
        }
        if (!snapshot.hasData) {
          // 데이터가 없을 경우 (API가 null을 반환하는 등)
          return const Center(child: Text("상품 데이터가 없습니다."));
        }

        final dataList = snapshot.data?.data?.items ?? [];
        final li0n = AppLocalizations.of(context)!;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // [추가] 추천 상품 목록(가로 스크롤) UI를 이곳으로 이동
            SizedBox(
              height: 298,
              child: dataList.isEmpty
                  ? const Center(child: Text("추천 상품이 없습니다.")) // 상품이 없을 경우 메시지 표시
                  : ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: dataList.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) => ProductsGridItem(dataList[index]),
              ),
            ),
            const Divider(color: AppColors.DividerTextBoxLineDivider,),
            Row(
              children: [
                Text(
                  li0n.home_OngoingFunding,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // TextButton(
                //   onPressed: (){},
                //   child: Text(
                //     li0n.more,
                //     style: const TextStyle(
                //         fontSize: 16,
                //         color: AppColors.grey,
                //         decoration: TextDecoration.underline
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 10,),
            BrandFundingSection(),
            const SizedBox(height: 10,),
            const Divider(color: AppColors.DividerTextBoxLineDivider,),
            CategoryHorizontalScroll(),
            const SizedBox(height: 20,),
            ProductsNonScrollableGrid(dataList)
          ],
        );
      },
    );
  }
}

class BrandFundingSection extends StatefulWidget {
  const BrandFundingSection({super.key});

  @override
  State<StatefulWidget> createState() {
    return BrandFundingSectionState();
  }
}

class BrandFundingSectionState extends State<BrandFundingSection> {
  final apiClient = FundingsApiClient();
  late Future<FundingsResponse> _fundingFuture;

  Future<FundingsResponse> _initializeProducts() async {
    return apiClient.fundings();
  }

  @override
  void initState() {
    super.initState();
    _fundingFuture = _initializeProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FundingsResponse>(
      future: _fundingFuture,
      builder: (context, snapshot) {
        final data = snapshot.data?.data?.items.take(3).toList() ?? [];
        return Column(
          children: data.map((item) {
            return FundingListItem(
              imageUrl: item.imageUrl ?? '',
              fundingName: item.title,
              brandName: item.companyId?.name ?? '브랜드 없음',
              description: item.description ?? item.linkUrl ?? '',
              linkUrl: item.linkUrl ?? '',
            );
          }).toList(),
        );
      },
    );
  }
}

class BrandNameSection extends StatelessWidget {
  final bool _isBrandMine;
  final String _BrandName;
  final String _BrandImageUrl;
  const BrandNameSection(this._isBrandMine, this._BrandName, this._BrandImageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final li0n = AppLocalizations.of(context);
    if (_isBrandMine) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 36,
            foregroundImage: (_BrandImageUrl.isNotEmpty) ? NetworkImage(_BrandImageUrl) : null,
            child: (_BrandImageUrl.isNotEmpty) ? null : const Icon(Icons.store, size: 36),
          ),
          const SizedBox(width: 15,),
          Text(_BrandName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
          const Spacer(),
          TextButton(
            onPressed: (){},
            child: Text(li0n!.edit, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 36,
          foregroundImage: (_BrandImageUrl.isNotEmpty) ? NetworkImage(_BrandImageUrl) : null,
          child: (_BrandImageUrl.isNotEmpty) ? null : const Icon(Icons.store, size: 36),
        ),
        const SizedBox(width: 15,),
        Text(_BrandName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
        const Spacer()
      ],
    );
  }
}
