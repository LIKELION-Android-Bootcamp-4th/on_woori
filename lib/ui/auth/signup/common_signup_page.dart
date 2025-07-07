import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/entity/request/auth/register_buyer_request.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/login_textfield.dart';

import '../../../l10n/app_localizations.dart';

class CommonSignupPage extends StatefulWidget {
  @override
  State<CommonSignupPage> createState() => _CommonSignupPageState();
}

class _CommonSignupPageState extends State<CommonSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final codeController = TextEditingController();
  final apiClient = AuthApiClient();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // 모든 유효성 통과
      String email = emailController.text;
      String password = passwordController.text;
      String nickName = textController.text;

      RegisterBuyerRequest request = RegisterBuyerRequest(email: email, password: password, nickName: nickName);

      apiClient.authRegisterBuyer(request: request);

      context.go('/auth/signup/completed');
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
              "공통",
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
                      controller: textController,
                      labelText: "닉네임",
                      hintText: "닉네임을 입력해주세요",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '내용을 입력해주세요';
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    LoginTextField(
                      controller: passwordController,
                      labelText: "비밀번호",
                      hintText: "비밀번호를 입력해주세요",
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '내용을 입력해주세요';
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    LoginTextField(
                      controller: passwordConfirmController,
                      labelText: "비밀번호 확인",
                      hintText: "비밀번호를 한번 더 입력해주세요",
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '내용을 입력해주세요';
                        if (passwordController.text != value) {
                          return '입력한 비밀번호가 서로 다릅니다';
                        }
                        if (value.length < 6) return '비밀번호는 6자리 이상이여야 합니다';
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: LoginTextField(
                            controller: emailController,
                            labelText: l10n.loginEmailTitle,
                            hintText: l10n.loginEmailInputHint,
                            inputType: TextInputType.emailAddress,
                            validator: (value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(pattern);

                              if (value == null || value.isEmpty)
                                return '내용을 입력해주세요';
                              if (!regExp.hasMatch(value))
                                return '잘못된 이메일 형식입니다';
                              return null;
                            },
                          ),
                        ),

                        SizedBox(width: 5),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: AppColors.primarySub,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "인증",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 15),
                    LoginTextField(
                      controller: codeController,
                      labelText: "인증번호",
                      hintText: "인증번호 6자리",
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '내용을 입력해주세요';
                        if (value.length != 6) return '인증코드는 6자리여야 합니다';
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
        child: BottomButton(buttonText: l10n.signInTitle, pressedFunc: _submit),
      ),
    );
  }
}
