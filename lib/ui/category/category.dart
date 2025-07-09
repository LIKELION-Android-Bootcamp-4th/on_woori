import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.bottomNavigationBarCategory, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/wish/cart');
            },
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: CategoryScreen(),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryScreenState();
  }
}

class CategoryScreenState extends State<CategoryScreen> { //세부카테고리
  int _selectedIndex = 0;

  void setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final li0n = AppLocalizations.of(context);
    List<Widget> screenItem = [];
    screenItem.add(CategoryListSection(setIndex));
    screenItem.add(SizedBox(width: 15,));
    switch (_selectedIndex) {
      case 0: {
        screenItem.add(CategoryDetailSection([
          li0n!.categoryOuter_coat,
          li0n.categoryOuter_jacket,
          li0n.categoryOuter_vest,
          li0n.categoryOuter_etc
        ], context));
        break;
      }
      case 1: {
        screenItem.add(CategoryDetailSection([
          li0n!.categoryTop_sleeveless,
          li0n.categoryTop_shortSleeve,
          li0n.categoryTop_longSleeve,
          li0n.categoryTop_shirt,
          li0n.categoryTop_etc
        ], context));
        break;
      }
      case 2: {
        screenItem.add(Column(
          children: [
            CategoryDetailSection(title: li0n!.categoryBottom_skirt, [
              li0n.categoryBottom_underSkirt,
              li0n.categoryBottom_longSkirt,
              li0n.categoryBottom_miniSkirt,
              li0n.categoryBottom_etcSkirt
            ], context),
            CategoryDetailSection(title: li0n.categoryBottom_pants, [
              li0n.categoryBottom_underPants,
              li0n.categoryBottom_shortPants,
              li0n.categoryBottom_longPants,
              li0n.categoryBottom_etcPants
            ], context)
          ],
        ));
        break;
      }
      case 3: {
        screenItem.add(CategoryDetailSection([
          li0n!.categoryGoods_head,
          li0n.categoryGoods_norigae,
          li0n.categoryGoods_neck,
          li0n.categoryGoods_ear,
          li0n.categoryGoods_ring,
          li0n.categoryGoods_bag,
          li0n.categoryGoods_etc
        ], context));
        break;
      }
    }
    screenItem.add(SizedBox(width: 24,)); //padding
    
    return SafeArea(
      child: Row(
        children: screenItem,
      ),
    );
  }
}

class CategoryListSection extends StatefulWidget { //카테고리 대분류 이름 섹션 (카테고리 바)
  Function(int) onCategorySelected;

  CategoryListSection(this.onCategorySelected);

  @override
  State<StatefulWidget> createState() {
    return CategoryListSectionState(onCategorySelected);
  }
}

class CategoryListSectionState extends State<CategoryListSection> {
  int _selectedIndex = 0; //카테고리 버튼 배경색 바꿔주는 것
  Function(int) onCategorySelected; //부모에게서 함수 받아 실행시킴으로서 update

  CategoryListSectionState(this.onCategorySelected);
  
  @override
  Widget build(BuildContext context) {
    final li0n = AppLocalizations.of(context);
    final List<String> categories = [li0n!.categoryOuter, li0n.categoryTop, li0n.categoryBottom, li0n.categoryGoods]; //Api 사용 불가로 명시중
    return Container(
      width: 120,
      color: AppColors.categoryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(categories.length, (index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            child: Container(
              width: double.infinity,
              height: 52,
              color: isSelected ? Colors.white : Colors.transparent,
              padding: EdgeInsets.only(left: 24, top: 16, bottom: 16),
              child: Text(categories[index], style: TextStyle(fontSize: 16, color: AppColors.grey),),
            ),
            onTap: (){
              setState(() {
                onCategorySelected(index);
              });
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        })
      ),
    );
  }
}

class CategoryDetailSection extends StatelessWidget { //카테고리 버튼 모음집 섹션
  String? title;
  final List<String> _itemList;
  BuildContext context;
  CategoryDetailSection(this._itemList, this.context, {this.title});

  List<Widget> _getCategoryWidget() {
    List<Widget> children = [];
    children.add(SizedBox(height: 16,));
    if (title != null) {
      children.add(
        Text(title!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
      );
      children.add(SizedBox(height: 15,));
    }
    for (int i = 0; i < _itemList.length-1; i++) {
      children.add(
          Row(
            children: [
              _getCategoryButton(i),
              SizedBox(width: 24,),
              _getCategoryButton(i+1)
            ],
          )
      );
      children.add(SizedBox(height: 20,));
      i++;
    }
    return children;
  }

  Widget _getCategoryButton(int index) {
    return Stack(
      children: [
        Positioned(
          top: 8,
          right: 10,
          child: SizedBox(
            width: 10,
            height: 16,
            child: Icon(Icons.chevron_right, color: AppColors.grey,),
          ),
        ),
        Positioned(
          bottom: 3,
          left: 0,
          child: Container(height: 1.0, width: 100, color: AppColors.DividerTextBoxLineDivider,),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))
            )
          ),
          onPressed: () {
            context.push("/productslist/${_itemList[index]}");
          },
          child: SizedBox(
            height: 32,
            width: 100,
            child: Text(_itemList[index], style: TextStyle(fontSize: 16, color: AppColors.grey),),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _getCategoryWidget();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getCategoryWidget(),
    );
  }
}