import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';

/// 기본 모드에서 사용하는 단일 항목 위젯 (수정/삭제 버튼 포함)
class BrandProductEditListItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String id;
  final int index;
  final Function(String) onEdit;
  final Function(int, String) deleteSelection;

  const BrandProductEditListItem({
    super.key,
    required this.name,
    required this.id,
    required this.index,
    required this.onEdit,
    required this.deleteSelection,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.grey.withOpacity(0.2),
              backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                  ? NetworkImage(imageUrl!)
                  : null,
              child: (imageUrl == null || imageUrl!.isEmpty)
                  ? const Icon(Icons.storefront, color: AppColors.grey)
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () => onEdit(id),
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              onPressed: () => deleteSelection(index, id),
              icon: const Icon(Icons.delete_outline),
            )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: AppColors.grey),
      ],
    );
  }
}

/// 다중 선택 모드에서 사용하는 단일 항목 위젯 (체크박스 포함)
class BrandProductMultiSelectItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final int index;
  final bool isSelected;
  final Function(bool?, int) onChanged;

  const BrandProductMultiSelectItem(
      this.name,
      this.index,
      this.isSelected,
      this.onChanged, {
        super.key,
        this.imageUrl,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.grey.withOpacity(0.2),
              backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                  ? NetworkImage(imageUrl!)
                  : null,
              child: (imageUrl == null || imageUrl!.isEmpty)
                  ? const Icon(Icons.storefront, color: AppColors.grey)
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                onChanged(value, index);
              },
            )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: AppColors.grey),
      ],
    );
  }
}