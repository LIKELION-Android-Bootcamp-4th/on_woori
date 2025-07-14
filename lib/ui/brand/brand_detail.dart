import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/core/styles/default_image.dart';
import 'package:on_woori/data/client/fundings_api_client.dart';
import 'package:on_woori/data/client/stores_api_client.dart';
import 'package:on_woori/data/entity/response/fundings/fundings_response.dart';
import 'package:on_woori/data/entity/response/stores/stores_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/category_horizontal_scroll.dart';
import 'package:on_woori/widgets/funding_list_item.dart';
import 'package:on_woori/widgets/products_double_grid.dart';
import 'package:on_woori/widgets/products_grid_item.dart';

import '../../data/entity/response/products/products_response.dart';


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
  late Future<StoreDetailResponse> _storesFuture;

  Future<StoreDetailResponse> _initializeData() async {
    return apiClient.storeDetail(widget.id);
  }

  @override
  void initState() {
    super.initState();
    _storesFuture = _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                false, //자기 브랜드일 때 넘겨주는 기능 결여되어 있으나 당장 추가 어려움
                data?.name ?? "브랜드 이름",
                data?.thumbnailImageUrl ?? DefaultImage.brandThumbnail
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
            const Divider(color: AppColors.dividerTextBoxLineDivider,),
            const SizedBox(height: 10,),
            Text(
              l10n!.home_RecommendedProducts,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10,),
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
  List<ProductItem> dataList = [];
  List<ProductItem> originalList = [];
  bool _isFiltering = false;

  @override
  void initState() {
    super.initState();
    _storesProductFuture = _initializeProducts();
  }

  Future<StoreProductsResponse> _initializeProducts() async {
    try {
      return apiClient.storeProductList(widget.id);
    } catch (e, s) {
      debugPrint("오류 내용: $e");
      debugPrint("스택 트레이스: $s");
      rethrow;
    }
  }

  void getFilteredItem(String category) async {
    setState(() {
      _isFiltering = true;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    List<ProductItem> filteredList;
    if (category == "전체") {
      filteredList = originalList;
    } else {
      filteredList = originalList.where((item) => item.category == category).toList();
    }

    setState(() {
      dataList = filteredList;
      _isFiltering = false;
    });
  }
  // -----------------------------------------

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreProductsResponse>(
      future: _storesProductFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 298,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Center(child: Text("상품 정보를 가져오지 못했습니다."));
        }
        if (!snapshot.hasData || snapshot.data!.data == null) {
          return const Center(child: Text("상품 데이터가 없습니다."));
        }

        // 🔽 Future가 완료된 후, 원본 리스트가 비어있을 때만 데이터를 한 번만 채웁니다.
        if (originalList.isEmpty) {
          originalList = snapshot.data!.data!.items;
          dataList = originalList;
        }

        final l10n = AppLocalizations.of(context)!;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 298,
              child: originalList.isEmpty
                  ? const Center(child: Text("추천 상품이 없습니다."))
                  : ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: originalList.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) => ProductsGridItem(originalList[index]),
              ),
            ),
            const Divider(color: AppColors.dividerTextBoxLineDivider,),
            Row(
              children: [
                Text(
                  l10n.home_OngoingFunding,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10,),
            BrandFundingSection(),
            const SizedBox(height: 10,),
            const Divider(color: AppColors.dividerTextBoxLineDivider,),
            CategoryHorizontalScroll(getFilteredItem: getFilteredItem,),
            const SizedBox(height: 20,),
            _isFiltering
                ? const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            )
                : ProductsNonScrollableGrid(dataList)
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
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final data = snapshot.data?.data?.items.take(3).toList() ?? [];
        if (data.isEmpty) {
          return const Center(child: Text("진행중인 펀딩이 없습니다."));
        }
        return Column(
          children: data.map((item) {
            return FundingListItem(
              id: item.id,
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
    final l10n = AppLocalizations.of(context);
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
            child: Text(l10n!.edit, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 36,
          child: (_BrandImageUrl.isNotEmpty)
              ? ClipOval(
            child: Image.network(
              _BrandImageUrl,
              fit: BoxFit.cover,
              height: 72,
              width: 72,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(DefaultImage.brandThumbnail, fit: BoxFit.cover, height: 72, width: 72,);
              },
            ),
          )
              : const Icon(Icons.store, size: 36),
        ),
        const SizedBox(width: 15,),
        Text(_BrandName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
        const Spacer()
      ],
    );
  }
}