import 'package:flutter/material.dart';

class ListToolbar extends StatelessWidget {
  int itemCount;

  ListToolbar(this.itemCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "상품 $itemCount개",
            style: TextStyle(color: Color(0xFF7D7D7D), fontSize: 16),
          ),
          InkWell(
            child: Text(
              "편집",
              style: TextStyle(
                color: Color(0xFF4A90E2),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}