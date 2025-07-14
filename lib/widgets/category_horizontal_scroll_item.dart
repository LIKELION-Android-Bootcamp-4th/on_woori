import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

class CategoryHorizontalScrollItem extends StatelessWidget {
  String buttonText;
  bool isSelected;
  VoidCallback onTap;

  CategoryHorizontalScrollItem(
    this.buttonText,
    this.isSelected,
    this.onTap, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? null : AppColors.categorySizeButton,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Color(0xFF7D7D7D) : Colors.black,
          ),
        ),
      ),
    );
  }
}
