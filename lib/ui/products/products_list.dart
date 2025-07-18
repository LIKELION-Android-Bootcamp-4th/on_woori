import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/client/search_api_client.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/products_double_grid.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';

class ProductsListPage extends StatelessWidget {
  final String categoryId;

  const ProductsListPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          categoryId,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/wish/cart');
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ProductsListScreen(categoryId: categoryId),
      ),
    );
  }
}

class ProductsListScreen extends StatelessWidget {
  final String categoryId;

  const ProductsListScreen({super.key, required this.categoryId});

  static const Map<String, String> categoryMap = {
    '코트': '아우터',
    '재킷': '아우터',
    '조끼': '아우터',
    '가디건 외': '아우터',
    '민소매': '상의',
    '반소매': '상의',
    '긴소매': '상의',
    '셔츠': '상의',
    '속치마': '하의',
    '허리치마': '하의',
    '미니스커트': '하의',
    '기타 치마': '하의',
    '속바지': '하의',
    '반바지': '하의',
    '긴바지': '하의',
    '기타 바지': '하의',
    '머리장식': '잡화',
    '노리개': '잡화',
    '목걸이': '잡화',
    '귀걸이': '잡화',
    '반지': '잡화',
    '가방': '잡화',
  };

  @override
  Widget build(BuildContext context) {
    final apiClient = SearchApiClient();
    final l10n = AppLocalizations.of(context)!;

    final midCategory = categoryMap[categoryId];
    final finalQuery =
    (midCategory != null) ? '$categoryId||$midCategory' : categoryId;

    final response = apiClient.searchByCategory(
      category: categoryId,
      query: finalQuery,
    );

    return FutureBuilder(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(l10n.productListPageError('${snapshot.error}')));
        }

        if (!snapshot.hasData) {
          return Center(child: Text(l10n.productListPageNoData));
        }

        try {
          final responseData =
          snapshot.data?.data['data'] as Map<String, dynamic>?;
          if (responseData == null) throw Exception('Data field is null');

          final productListJson = responseData['products'] as List<dynamic>?;
          if (productListJson == null || productListJson.isEmpty) {
            return Center(child: Text(l10n.productListPageEmpty));
          }

          final productList = productListJson
              .map(
                (itemJson) =>
                ProductItem.fromJson(itemJson as Map<String, dynamic>),
          )
              .toList();

          return ProductsDoubleGrid(productList);
        } catch (e) {
          return Center(
              child: Text(l10n.productListPageProcessingError(e.toString())));
        }
      },
    );
  }
}
