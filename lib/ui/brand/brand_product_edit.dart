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
  String brandId;
  BrandProductEditPage({super.key, required this.brandId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            l10n.productManagementPageTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Text(l10n.productManagementProductTab)),
              Tab(icon: Text(l10n.productManagementFundingTab)),
            ],
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
        ),
        body: TabBarView(
          children: [BrandProductEditScreen(), BrandFundingEditScreen(brandId: brandId,)],
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
  final adminApiClient = ProductsApiClient();

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
        final filteredList = response.data!.items!
            .where((item) => item.isDeleted != true)
            .toList();

        setState(() {
          productList = filteredList; // 필터링된 리스트를 사용합니다.
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

  void _refreshData() {
    _loadProducts();
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
    final l10n = AppLocalizations.of(context)!;
    final idsToDelete = <String>[];
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        idsToDelete.add(productList[i].id);
      }
    }
    if (idsToDelete.isEmpty) {
      _showSnackBar(l10n.commonSelectItemToDelete);
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.productBulkDeleteTitle),
        content: Text(l10n.productBulkDeleteConfirm(idsToDelete.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonDelete),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isLoading = true);

    for (final id in idsToDelete) {
      try {
        await adminApiClient.deleteProductForce(id: id);
      } catch (e) {
        debugPrint("상품($id) 삭제 실패: $e");
        _showSnackBar(l10n.productBulkDeleteFailed, isError: true);
        break;
      }
    }

    _showSnackBar(l10n.productBulkDeleteSuccess(idsToDelete.length));
    await _loadProducts();
    setState(() => selecting = false);
  }

  void deleteSelection(int index, String id) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.productDeleteTitle),
        content: Text(l10n.productDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonDelete),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isLoading = true);

    try {
      await adminApiClient.deleteProductForce(id: id);
      _showSnackBar(l10n.productDeleteSuccess);
      await _loadProducts();
    } catch (e) {
      _showSnackBar(l10n.commonDeleteFailed('$e'), isError: true);
      debugPrint("삭제 실패: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void editSelection(String id) async {
    debugPrint("수정할 상품 ID: $id");
    final result = await context.push('/productedit/$id');
    if (result == true) {
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selecting) {
      bool isAllSelected =
          productList.isNotEmpty && selectionList.every((selected) => selected);
      return _buildMultiSelectView(isAllSelected, l10n);
    }

    return _buildSingleSelectView(l10n);
  }

  Widget _buildMultiSelectView(bool isAllSelected, AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Row(
          children: [
            Text(
              l10n.productSelectedCount(selectionList.where((e) => e).length),
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
            ),
            const Spacer(),
            TextButton(
              onPressed: toggleSelectAll,
              child: Text(isAllSelected ? l10n.commonDeselectAll : l10n.commonSelectAll),
            ),
            TextButton(
              onPressed: deleteMultiSelection,
              child: Text(l10n.commonDeleteSelected),
            ),
            TextButton(
              onPressed: () => setState(() => selecting = false),
              child: Text(l10n.commonCancel),
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
            return BrandProductMultiSelectItem(
              item.name,
              index,
              selectionList[index],
              onChanged,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSingleSelectView(AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Row(
          children: [
            Text(
              l10n.productOnSaleCount(productList.length),
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => setState(() => selecting = true),
              child: Text(l10n.commonMultiSelect),
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
  String brandId;
  BrandFundingEditScreen({super.key, required this.brandId});

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
          fundingList = response.data?.items.where((item) => item.userId?.id == widget.brandId).toList() ?? [];
          selectionList = List.filled(fundingList.length, false);
        });
      }
    } catch (e) {
      debugPrint("펀딩 조회 오류: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _refreshData() {
    _loadFunding();
  }

  void deleteSelection(int index, String id) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final res = await fundingApiClient.deleteFunding(id: id);
      if (res.success) {
        _refreshData();
      }
    } catch (e) {
      debugPrint("삭제 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonDeleteFailed('$e'))),
      );
    }
  }

  void deleteMultiSelection() async {
    final l10n = AppLocalizations.of(context)!;
    List<String> idsToDelete = [];
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        idsToDelete.add(fundingList[i].id);
      }
    }

    if (idsToDelete.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonSelectItemToDelete)),
      );
      return;
    }

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

  void editSelection(String id) async {
    debugPrint("수정할 펀딩 ID: $id");
    final result = await context.push('/funding/edit/$id');
    if (result == true) {
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.fundingSelectedCount(selectionList.where((e) => e).length),
                style: const TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const Spacer(),
              TextButton(
                onPressed: toggleSelectAll,
                child: Text(
                  isAllSelected ? l10n.commonDeselectAll : l10n.commonSelectAll,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.editDeleteTextButton,
                  ),
                ),
              ),
              TextButton(
                onPressed: deleteMultiSelection,
                child: Text(
                  l10n.commonDeleteSelected,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.editDeleteTextButton,
                  ),
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
                imageUrl: item.thumbnailImageUrl,
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
              l10n.fundingRegisteredCount(fundingList.length),
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                setState(() => selecting = true);
              },
              child: Text(
                l10n.commonMultiSelect,
                style: const TextStyle(color: AppColors.editDeleteTextButton),
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
              imageUrl: item.thumbnailImageUrl,
            );
          },
        ),
      ],
    );
  }
}
