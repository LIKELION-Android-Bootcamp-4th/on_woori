import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

class BrandProductEditListItem extends StatelessWidget {
  //단일
  String name;
  int index;
  String id;
  Function(int, String) deleteSelection;

  BrandProductEditListItem({
    super.key,
    required this.name,
    required this.index,
    required this.id,
    required this.deleteSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(backgroundColor: AppColors.primary, radius: 36),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            IconButton(
              onPressed: () => deleteSelection(index, id),
              icon: Icon(Icons.delete),
            ),
          ],
        ),

        SizedBox(height: 10),
        Divider(color: AppColors.grey),
      ],
    );
  }
}

class BrandProductMultiSelectItem extends StatelessWidget {
  //다중
  String name;
  int index;
  bool isSelected;
  Function(bool?, int) onChanged;

  BrandProductMultiSelectItem(
    this.name,
    this.index,
    this.isSelected,
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(backgroundColor: AppColors.primary, radius: 36),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                onChanged(value, index);
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(color: AppColors.grey),
      ],
    );
  }
}
