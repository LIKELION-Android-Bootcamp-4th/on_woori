import 'package:flutter/material.dart';
import '../core/styles/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final Size buttonSize = button.size;
            final Offset buttonPosition = button.localToGlobal(Offset.zero);

            final result = await showDialog<String>(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) {
                return Stack(
                  children: [
                    Positioned(
                      left: buttonPosition.dx,
                      top: buttonPosition.dy + 24,
                      width: buttonSize.width,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.dividerTextBoxLineDivider),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              final bool isLast = index == items.length - 1;

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop(item);
                                    },
                                    child: Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!isLast)
                                    Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: AppColors.dividerTextBoxLineDivider.withOpacity(0.5),
                                    ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );

            if (result != null && result != selectedValue) {
              onChanged(result);
            }
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.dividerTextBoxLineDivider),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}
