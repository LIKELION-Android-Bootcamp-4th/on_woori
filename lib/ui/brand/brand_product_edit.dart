import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/client/seller_fundings_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/data/entity/response/seller/fundings/seller_funding_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/brand_product_edit_item.dart';

class BrandProductEditPage extends StatelessWidget {
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
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
        body: TabBarView(
          children: [BrandProductEditScreen(), BrandFundingEditScreen()],
        ),
      ),
    );
  }
}

class BrandProductEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BrandProductEditScreenState();
  }
}

class BrandProductEditScreenState extends State<BrandProductEditScreen> {
  final productApiClient = ProductsApiClient();

  final tempIndex = 3;
  bool selecting = false;
  List<ProductItem> tempList = [];
  List<bool> selectionList = [];

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

  void deleteMultiSelection() {
    List<ProductItem> deletedList = List.from(tempList);
    List<bool> deletedSelection = List.from(selectionList);
    for (int i = tempList.length - 1; i >= 0; i--) {
      if (selectionList[i]) {
        deletedList.removeAt(i);
        deletedSelection.removeAt(i);
      }
    }
    setState(() {
      tempList = List.from(deletedList);
      selectionList = List.from(deletedSelection);
      selecting = false;
    });
  }

  void deleteSelection(int index, String id) {
    setState(() {
      tempList.removeAt(index);
      selectionList.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < tempIndex; i++) {
      tempList.add(
        ProductItem(id: "id", name: "시험상품", price: 1000, isFavorite: false),
      );
      selectionList.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productResponse = productApiClient.products();

    if (selecting) {
      bool isAllSelected = selectionList.every((selected) => selected);

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          Row(
            children: [
              Text(
                "선택된 상품 ${selectionList.where((e) => e).length}개",
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  toggleSelectAll();
                },
                child: Text(
                  isAllSelected ? "전체 해제" : "모두 선택",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.editDeleteTextButton,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteMultiSelection();
                },
                child: Text(
                  "선택 삭제",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.editDeleteTextButton,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tempList.length,
            itemBuilder: (context, index) {
              final item = tempList[index];
              final selected = selectionList[index];
              return BrandProductMultiSelectItem(
                item.name,
                index,
                selected,
                onChanged,
              );
            },
          ),
        ],
      );
    }

    return FutureBuilder<ProductsResponse>(
      future: productResponse,
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
        final productsList = (snapshot.data?.data?.items ?? []);

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            Row(
              children: [
                Text(
                  "판매중 상품 ${productsList.length}개",
                  style: TextStyle(fontSize: 16, color: AppColors.grey),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selecting = true;
                    });
                  },
                  child: Text(
                    "다중선택",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.editDeleteTextButton,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                final item = productsList[index];
                return BrandProductEditListItem(
                  name: item.name,
                  index: index,
                  id: item.id,
                  deleteSelection: deleteSelection,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class BrandFundingEditScreen extends StatefulWidget {
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFunding();
    for (int i = 0; i < fundingList.length; i++) {
      fundingList.add(
        SellerFundingItem(
          id: "id",
          title: "펀딩 이름",
          imageUrl: "imageUrl",
          linkUrl: "linkUrl",
        ),
      );
      selectionList.add(false);
    }
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
    try {
      final response = await fundingApiClient.sellerFunding();
      if (response.success) {
        setState(() {
          fundingList = response.data?.items ?? [];
          selectionList = List.filled(fundingList.length, false);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  void deleteSelection(int index, String id) async {
    try {
      final res = await fundingApiClient.deleteFunding(id: id);
      if (res.success) {
        setState(() {
          fundingList.removeAt(index);
        });
      }
    } catch (e) {
      print("삭제 실패: $e");
    }
  }
  void deleteMultiSelection() async {
    List<int> toDeleteIndexes = [];

    // 선택된 index 목록을 먼저 수집
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        toDeleteIndexes.add(i);
      }
    }

    // 역순으로 삭제 (index 안정성 확보)
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
    if (selecting) {
      bool isAllSelected = selectionList.every((selected) => selected);

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          Row(
            children: [
              Text(
                "선택된 상품 ${selectionList.where((e) => e).length}개",
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  toggleSelectAll();
                },
                child: Text(
                  isAllSelected ? "전체 해제" : "모두 선택",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.editDeleteTextButton,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteMultiSelection();
                },
                child: Text(
                  "선택 삭제",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.editDeleteTextButton,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Row(
          children: [
            Text(
              "등록된 펀딩 ${fundingList.length}개",
              style: TextStyle(fontSize: 16, color: AppColors.grey),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                setState(() => selecting = true);
              },
              child: Text(
                "다중선택",
                style: TextStyle(color: AppColors.editDeleteTextButton),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: fundingList.length,
          itemBuilder: (context, index) {
            final item = fundingList[index];
            return BrandProductEditListItem(
              name: item.title,
              index: index,
              id: item.id,
              deleteSelection: deleteSelection,
            );
          },
        ),
      ],
    );
  }
}
