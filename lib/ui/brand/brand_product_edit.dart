import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/admin_api_client.dart';
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
  final adminApiClient = AdminApiClient();

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
    setState(() => isLoading = true);
    try {
      final response = await productApiClient.sellerProducts();
      if (mounted && response.success && response.data?.items != null) {
        setState(() {
          productList = response.data!.items!;
          selectionList = List.filled(productList.length, false);
        });
      }
    } catch (e) {
      debugPrint("상품 조회 오류: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  // 🚀 [수정] 이 함수는 UI 상태를 변경하지 않고 순수하게 로그인 기능만 담당하도록 변경
  Future<bool> _ensureAdminLogin() async {
    final success = await adminApiClient.loginAsAdmin();
    if (!success && mounted) {
      _showSnackBar('관리자 인증에 실패했습니다.', isError: true);
    }
    return success;
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

  void deleteMultiSelection() async {
    final idsToDelete = <String>[];
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        idsToDelete.add(productList[i].id);
      }
    }
    if (idsToDelete.isEmpty) {
      _showSnackBar('삭제할 상품을 선택해주세요.');
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('상품 일괄 삭제'),
        content: Text('${idsToDelete.length}개의 상품을 정말로 삭제하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('취소')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('삭제'), style: TextButton.styleFrom(foregroundColor: Colors.red)),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isLoading = true);
    if (await _ensureAdminLogin() == false) {
      setState(() => isLoading = false); // 로그인 실패 시 로딩 종료
      return;
    }

    for (final id in idsToDelete) {
      try {
        await adminApiClient.deleteProductForce(id: id);
      } catch (e) {
        debugPrint("상품($id) 삭제 실패: $e");
        _showSnackBar('일부 상품 삭제에 실패했습니다.', isError: true);
        break;
      }
    }

    _showSnackBar('${idsToDelete.length}개의 상품이 삭제되었습니다.');
    await _loadProducts(); // 목록 새로고침
    setState(() => selecting = false);
  }

  void deleteSelection(int index, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('상품 삭제'),
        content: const Text('정말로 이 상품을 삭제하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('취소')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('삭제'), style: TextButton.styleFrom(foregroundColor: Colors.red)),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isLoading = true); // 🚀 [수정] 여기서 로딩을 시작하고

    if (await _ensureAdminLogin() == false) {
      setState(() => isLoading = false); // 로그인 실패 시 로딩 종료
      return;
    }

    try {
      await adminApiClient.deleteProductForce(id: id);
      _showSnackBar('상품이 삭제되었습니다.');
      await _loadProducts();
    } catch (e) {
      _showSnackBar('삭제에 실패했습니다: $e', isError: true);
      debugPrint("삭제 실패: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false); // 🚀 [수정] 모든 작업이 끝나면 여기서 로딩을 종료
      }
    }
  }

  void editSelection(String id) {
    debugPrint("수정할 상품 ID: $id");
    context.push('/productedit/$id');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selecting) {
      bool isAllSelected = productList.isNotEmpty && selectionList.every((selected) => selected);
      return _buildMultiSelectView(isAllSelected);
    }

    return _buildSingleSelectView();
  }

  Widget _buildMultiSelectView(bool isAllSelected) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Row(
          children: [
            Text("선택된 상품 ${selectionList.where((e) => e).length}개"),
            const Spacer(),
            TextButton(onPressed: toggleSelectAll, child: Text(isAllSelected ? "전체 해제" : "모두 선택")),
            TextButton(onPressed: deleteMultiSelection, child: const Text("선택 삭제")),
            TextButton(onPressed: () => setState(() => selecting = false), child: const Text("취소")),
          ],
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final item = productList[index];
            return BrandProductMultiSelectItem(item.name, index, selectionList[index], onChanged);
          },
        ),
      ],
    );
  }

  Widget _buildSingleSelectView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Row(
          children: [
            Text("판매중 상품 ${productList.length}개"),
            const Spacer(),
            TextButton(
              onPressed: () => setState(() => selecting = true),
              child: const Text("다중선택"),
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
              deleteSelection: deleteSelection,
              onEdit: editSelection,
              imageUrl: item.thumbnailImage?.url,
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
      if (mounted && response.success) {
        setState(() {
          fundingList = response.data?.items ?? [];
          selectionList = List.filled(fundingList.length, false);
        });
      }
    } catch (e) {
      debugPrint("펀딩 조회 오류: $e");
    } finally {
      if(mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _refreshData() {
    _loadFunding();
  }

  void deleteSelection(int index, String id) async {
    try {
      final res = await fundingApiClient.deleteFunding(id: id);
      if (res.success) {
        _refreshData();
      }
    } catch (e) {
      debugPrint("삭제 실패: $e");
    }
  }

  void deleteMultiSelection() async {
    List<String> idsToDelete = [];
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        idsToDelete.add(fundingList[i].id);
      }
    }

    if (idsToDelete.isEmpty) return;

    for (final id in idsToDelete) {
      try {
        await fundingApiClient.deleteFunding(id: id);
      } catch (e) {
        debugPrint("$id 삭제 실패: $e");
      }
    }

    _refreshData();
    setState(() {
      selecting = false;
    });
  }

  void onChanged(bool? flag, int index) {
    setState(() {
      selectionList[index] = flag ?? false;
    });
  }

  void editSelection(String id) {
    debugPrint("수정할 펀딩 ID: $id");
    context.push('/funding/edit/$id');
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selecting) {
      bool isAllSelected =
          fundingList.isNotEmpty && selectionList.every((selected) => selected);

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
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.editDeleteTextButton),
                ),
              ),
              TextButton(
                onPressed: deleteMultiSelection,
                child: const Text(
                  "선택 삭제",
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.editDeleteTextButton),
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
                imageUrl: item.imageUrl,
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
              deleteSelection: deleteSelection,
              onEdit: editSelection,
              imageUrl: item.imageUrl,
            );
          },
        ),
      ],
    );
  }
}