import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/widgets/bottom_button.dart';

import '../../../l10n/app_localizations.dart';

class CompletedSignupPage extends StatelessWidget {
  final nameController = TextEditingController();
  final introController = TextEditingController();

  CompletedSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    void submit() {
      context.go('/');
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              l10n.signInTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "온우리에 오신 것을 환영합니다!",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: BottomButton(buttonText: "메인화면으로", pressedFunc: submit),
      ),
    );
  }
}
