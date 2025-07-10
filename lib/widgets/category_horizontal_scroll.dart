import 'package:flutter/material.dart';

import 'category_horizontal_scroll_item.dart';

class CategoryHorizontalScroll extends StatefulWidget {
  Function(String category)? getFilteredItem;
  CategoryHorizontalScroll({super.key, this.getFilteredItem});

  @override
  State<StatefulWidget> createState() => CategoryHorizontalScrollState();
}

class CategoryHorizontalScrollState extends State<CategoryHorizontalScroll> {
  int selectedIndex = 0;
  List<String> categories = ["전체", "상의", "하의", "아우터", "신발", "악세사리"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          return CategoryHorizontalScrollItem(
            categories[index],
            selectedIndex != index,
            () {
              setState(() {
                selectedIndex = index;
              });
              if (widget.getFilteredItem != null) {
                widget.getFilteredItem!(categories[index]);
              }
            },
          );
        }),
      ),
    );
  }
}