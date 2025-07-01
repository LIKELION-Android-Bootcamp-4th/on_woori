import 'package:flutter/material.dart';
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
              onPressed: (){},
              icon: Image.asset("images/icon/cart.png")
          )
        ],
      ),
      body: ProductsListScreen()
    );
  }
}

class ProductsListScreen extends StatelessWidget {
  //TODO: API 사용하여 상품리스트 받아오고, 카테고리 필터링하기
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 24,),
        Expanded(child: ProductsDoubleGrid(10),),
        SizedBox(width: 24,)
      ],
    );
  }
}