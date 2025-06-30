import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const AppBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: l10n.bottomNavigationBarHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.category),
          label: l10n.bottomNavigationBarCategory,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: l10n.bottomNavigationBarWish,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: l10n.bottomNavigationBarMyPage,
        ),
      ],
      currentIndex: selectedIndex,

      onTap: onItemTapped,

      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      showUnselectedLabels: true,
    );
  }
}