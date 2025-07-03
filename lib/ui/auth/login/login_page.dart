import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/login_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageStatus();
}

class LoginPageStatus extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.network(
                    "https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 1, // 나머지 절반
                  child: Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.loginTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 40),
                        LoginTextField(
                          labelText: l10n.loginEmailTitle,
                          hintText: l10n.loginEmailInputHint,
                        ),
                        SizedBox(height: 15),
                        LoginTextField(
                          labelText: l10n.loginPasswordTitle,
                          hintText: l10n.loginPasswordInputHint,
                        ),
                        BottomButton(l10n.loginTitle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Text(
                                l10n.signInTitle,
                                style: TextStyle(
                                  color: AppColors.primarySub,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                // context.go();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
