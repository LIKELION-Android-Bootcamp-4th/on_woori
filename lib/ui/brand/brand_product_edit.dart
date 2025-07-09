import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/client/seller_fundings_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/data/entity/response/seller/fundings/seller_funding_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/brand_product_edit_item.dart';

class BrandProductEditPage extends StatelessWidget {
  const BrandProductEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final li0n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            li0n!.brandProductEditTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Text("상품")),
              Tab(icon: Text("펀딩")),
            ],
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
        ),
        body: const TabBarView(
          children: [BrandProductEditScreen(), BrandFundingEditScreen()],
        ),
      ),
    );
  }
}

class BrandProductEditScreen extends StatefulWidget {
  const BrandProductEditScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return BrandProductEditScreenState();
  }
}

class BrandProductEditScreenState extends State<BrandProductEditScreen> {
  final productApiClient = ProductsApiClient();
  bool isLoading = true;
  bool selecting = false;

  List<ProductItem> productList = [];
  List<bool> selectionList = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final response = await productApiClient.products();
      if (response.success && response.data?.items != null) {
        setState(() {
          productList = response.data!.items!;
          selectionList = List.filled(productList.length, false);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("상품 조회 오류: $e");
      setState(() => isLoading = false);
    }
  }

  void onChanged(bool? flag, int index) {
    setState(() {
      selectionList[index] = flag ?? false;
    });
  }

  void toggleSelectAll() {
    final selectAll = selectionList.any((selected) => !selected);
    setState(() {
      for (int i = 0; i < selectionList.length; i++) {
        selectionList[i] = selectAll;
      }
    });
  }

  // 🚀 [수정] 다중 선택 삭제 시 API 호출
  void deleteMultiSelection() async {
    List<String> idsToDelete = [];
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        idsToDelete.add(productList[i].id);
      }
    }

    if (idsToDelete.isEmpty) return;

    // TODO: 상품 여러개 삭제 API가 있다면 한번에 호출, 없다면 for문으로 개별 호출
    // 예시: for (final id in idsToDelete) { await productApiClient.deleteProduct(id: id); }

    // API 호출 후 데이터 새로고침
    await _loadProducts();
    setState(() => selecting = false);
  }

  // 🚀 [수정] 단일 선택 삭제 시 API 호출
  void deleteSelection(int index, String id) async {
    try {
      // TODO: 상품 단일 삭제 API 호출 (예시)
      // final res = await productApiClient.deleteProduct(id: id);
      // if (res.success) {
      //   setState(() {
      //     productList.removeAt(index);
      //     selectionList.removeAt(index);
      //   });
      // }
      print("삭제 요청: $id"); // 임시 로직
      setState(() {
        productList.removeAt(index);
        selectionList.removeAt(index);
      });

    } catch (e) {
      print("삭제 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selecting) {
      bool isAllSelected = selectionList.isNotEmpty && selectionList.every((selected) => selected);

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Row(
            children: [
              Text(
                "선택된 상품 ${selectionList.where((e) => e).length}개",
                style: const TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const Spacer(),
              TextButton(
                onPressed: toggleSelectAll,
                child: Text(
                  isAllSelected ? "전체 해제" : "모두 선택",
                  style: const TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),
                ),
              ),
              TextButton(
                onPressed: deleteMultiSelection,
                child: const Text(
                  "선택 삭제",
                  style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final item = productList[index];
              final selected = selectionList[index];
              return BrandProductMultiSelectItem(item.name, index, selected, onChanged);
            },
          )
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Row(
          children: [
            Text(
              "판매중 상품 ${productList.length}개",
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                setState(() {
                  selecting = true;
                });
              },
              child: const Text(
                "다중선택",
                style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final item = productList[index];
            return BrandProductEditListItem(
              name: item.name,
              index: index,
              id: item.id,
              deleteSelection: deleteSelection, onEdit: (String ) {  },
            );
          },
        ),
      ],
    );
  }
}

class BrandFundingEditScreen extends StatefulWidget {
  const BrandFundingEditScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return BrandFundingEditScreenState();
  }
}

class BrandFundingEditScreenState extends State<BrandFundingEditScreen> {
  final fundingApiClient = SellerFundingsApiClient();
  List<SellerFundingItem> fundingList = [];
  List<bool> selectionList = [];
  bool selecting = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFunding();
    // 🚀 [수정] initState에서는 비동기 로딩을 호출하기만 하고, 리스트 조작은 _loadFunding에서 처리합니다.
  }

  void toggleSelectAll() {
    final selectAll = selectionList.any((selected) => !selected);
    setState(() {
      for (int i = 0; i < selectionList.length; i++) {
        selectionList[i] = selectAll;
      }
    });
  }

  Future<void> _loadFunding() async {
    setState(() => isLoading = true);
    try {
      final response = await fundingApiClient.sellerFunding();
      if (response.success) {
        setState(() {
          fundingList = response.data?.items ?? [];
          selectionList = List.filled(fundingList.length, false);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("펀딩 조회 오류: $e");
      setState(() => isLoading = false);
    }
  }

  void deleteSelection(int index, String id) async {
    try {
      final res = await fundingApiClient.deleteFunding(id: id);
      if (res.success) {
        setState(() {
          fundingList.removeAt(index);
          selectionList.removeAt(index);
        });
      }
    } catch (e) {
      print("삭제 실패: $e");
    }
  }

  void deleteMultiSelection() async {
    List<int> toDeleteIndexes = [];
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        toDeleteIndexes.add(i);
      }
    }

    // 역순으로 삭제해야 인덱스가 꼬이지 않습니다.
    for (int i = toDeleteIndexes.length - 1; i >= 0; i--) {
      final index = toDeleteIndexes[i];
      final id = fundingList[index].id;
      try {
        final res = await fundingApiClient.deleteFunding(id: id);
        if (res.success) {
          fundingList.removeAt(index);
          selectionList.removeAt(index);
        } else {
          print("삭제 실패: ${res.message}");
        }
      } catch (e) {
        print("예외 발생: $e");
      }
    }

    setState(() {
      selecting = false;
    });
  }

  void onChanged(bool? flag, int index) {
    setState(() {
      selectionList[index] = flag ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selecting) {
      bool isAllSelected = selectionList.isNotEmpty && selectionList.every((selected) => selected);

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Row(
            children: [
              Text(
                "선택된 펀딩 ${selectionList.where((e) => e).length}개",
                style: const TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const Spacer(),
              TextButton(
                onPressed: toggleSelectAll,
                child: Text(
                  isAllSelected ? "전체 해제" : "모두 선택",
                  style: const TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),
                ),
              ),
              TextButton(
                onPressed: deleteMultiSelection,
                child: const Text(
                  "선택 삭제",
                  style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fundingList.length,
            itemBuilder: (context, index) {
              final item = fundingList[index];
              final selected = selectionList[index];
              return BrandProductMultiSelectItem(
                item.title,
                index,
                selected,
                onChanged,
              );
            },
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Row(
          children: [
            Text(
              "등록된 펀딩 ${fundingList.length}개",
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                setState(() => selecting = true);
              },
              child: const Text(
                "다중선택",
                style: TextStyle(color: AppColors.editDeleteTextButton),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fundingList.length,
          itemBuilder: (context, index) {
            final item = fundingList[index];
            return BrandProductEditListItem(
              name: item.title,
              index: index,
              id: item.id,
              deleteSelection: deleteSelection, onEdit: (String ) {  },
            );
          },
        ),
      ],
    );
  }
}