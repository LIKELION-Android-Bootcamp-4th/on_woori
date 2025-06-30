import 'package:flutter/material.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bottomNavigationBarCategory),
      ),
      body: Center(
        child: Text(
          l10n.bottomNavigationBarCategory,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}