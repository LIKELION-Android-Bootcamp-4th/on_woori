import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/login_textfield.dart';

import '../../../l10n/app_localizations.dart';

class CompletedSignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final introController = TextEditingController();

  CompletedSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    void submit() {
      if (_formKey.currentState!.validate()) {
        // 모든 유효성 통과
        context.go('/');
      }
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
