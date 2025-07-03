import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/products_double_grid.dart';

class ProductsListPage extends StatelessWidget {
  String? categoryId;
  ProductsListPage({this.categoryId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            categoryId ?? l10n!.appTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          actions: [
            IconButton(
                onPressed: (){
                  context.push('/wish/cart');
                },
                icon: Icon(Icons.shopping_bag_outlined)
            )
          ],
        ),
        body: ProductsListScreen()
    );
  }
}

class ProductsListScreen extends StatelessWidget {
  final apiClient = ProductsApiClient();

  @override
  Widget build(BuildContext context) {
    final response = apiClient.products();

    return FutureBuilder(
      future: response,
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

        final data = snapshot.data?.data?.items ?? [];
        return Row(
          children: [
            SizedBox(width: 24,),
            Expanded(child: ProductsDoubleGrid(data),),
            SizedBox(width: 24,)
          ],
        );
      },
    );
  }
}