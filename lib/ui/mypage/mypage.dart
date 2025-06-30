import 'package:flutter/material.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bottomNavigationBarMyPage),
      ),
      body: Center(
        child: Text(
          l10n.bottomNavigationBarMyPage,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}