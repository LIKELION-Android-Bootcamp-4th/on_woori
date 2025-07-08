import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/client/search_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/products_double_grid.dart';

class ProductsListPage extends StatelessWidget {
  final String category;
  final String query;

  ProductsListPage({
    required this.category,
    required this.query,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          query.isNotEmpty ? query : l10n!.appTitle,
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
      body: ProductsListScreen(category: category, query: query),
    );
  }
}

class ProductsListScreen extends StatelessWidget {
  final String category;
  final String query;
  final apiClient = SearchApiClient();

  ProductsListScreen({
    required this.category,
    required this.query,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiClient.searchByCategory(category: category, query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data?.data == null) {
          return const Center(child: Text('데이터가 없습니다.'));
        }

        final itemsJson = snapshot.data!.data['items'] as List<dynamic>? ?? [];
        final items = itemsJson.map((e) => ProductItem.fromJson(e)).toList();

        if (items.isEmpty) {
          return const Center(child: Text('검색 결과가 없습니다.'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ProductsDoubleGrid(items),
        );
      },
    );
  }
}
