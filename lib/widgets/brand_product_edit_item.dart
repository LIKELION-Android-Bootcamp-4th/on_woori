import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

class BrandProductEditListItem extends StatelessWidget { //단일
  String name;
  int index;
  Function(int) deleteSelection;
  BrandProductEditListItem(this.name, this.index, this.deleteSelection);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            CircleAvatar(backgroundColor: AppColors.primary, radius: 36,),
            SizedBox(width: 15,),
            Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
            Spacer(),
            IconButton(
              onPressed: (){}, //TODO: 함수 input으로 받아서 edit 화면으로 넘겨주기
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: (){
                deleteSelection(index);
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        SizedBox(height: 10,),
        Divider(color: AppColors.grey,)
      ],
    );
  }
}

class BrandProductMultiSelectItem extends StatelessWidget { //다중
  String name;
  int index;
  bool isSelected;
  Function(bool?, int) onChanged;
  BrandProductMultiSelectItem(this.name, this.index, this.isSelected, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            CircleAvatar(backgroundColor: AppColors.primary, radius: 36,),
            SizedBox(width: 15,),
            Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
            Spacer(),
            Checkbox(
                value: isSelected,
                onChanged: (value) {
                  onChanged(value, index);
                }
            )
          ],
        ),
        SizedBox(height: 10,),
        Divider(color: AppColors.grey,)
      ],
    );
  }
}