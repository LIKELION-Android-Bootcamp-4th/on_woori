import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/core/styles/default_image.dart';

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
              child: ClipOval(
                child: Image.network(
                  imageUrl ?? DefaultImage.productThumbnail,
                  fit: BoxFit.cover,
                  width: 72,
                  height: 72,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(DefaultImage.productThumbnail, fit: BoxFit.cover, width: 72, height: 72,);
                  },
                ),
              ),
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

// 다중 선택 위젯도 동일하게 수정합니다.
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
              child: ClipOval(
                child: Image.network(
                  imageUrl ?? DefaultImage.productThumbnail,
                  fit: BoxFit.cover,
                  width: 72,
                  height: 72,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(DefaultImage.productThumbnail, fit: BoxFit.cover, width: 72, height: 72,);
                  },
                ),
              ),
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