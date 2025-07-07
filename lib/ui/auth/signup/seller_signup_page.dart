import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/login_textfield.dart';

import '../../../data/entity/request/auth/register_seller_request.dart';
import '../../../l10n/app_localizations.dart';

class SellerSignupPage extends StatefulWidget {
  @override
  State<SellerSignupPage> createState() => _SellerSignupPageState();
}

class _SellerSignupPageState extends State<SellerSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final introController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // 모든 유효성 통과
      StoreRequestData store = StoreRequestData(name: nameController.text, description: introController.text);
      context.go('/auth/signup/common', extra: {
        'store': store
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              l10n.signInTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(width: 10),
            Text(
              "사장님",
              style: TextStyle(color: AppColors.primarySub, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    LoginTextField(
                      controller: nameController,
                      labelText: "상호명",
                      hintText: "상호명",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '내용을 입력해주세요';
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    LoginTextField(
                      controller: introController,
                      labelText: "한 줄 소개",
                      hintText: "한 줄 소개를 입력해주세요",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '내용을 입력해주세요';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: BottomButton(buttonText: "계속", pressedFunc: _submit),
      ),
    );
  }
}
