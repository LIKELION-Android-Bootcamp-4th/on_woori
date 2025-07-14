
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/entity/request/auth/register_buyer_request.dart';
import 'package:on_woori/data/entity/request/auth/register_seller_request.dart';
import 'package:on_woori/data/entity/response/auth/login_response.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/login_textfield.dart';

import '../../../l10n/app_localizations.dart';

class CommonSignupPage extends StatefulWidget {
  final StoreRequestData? store;

  const CommonSignupPage({
    this.store,
    super.key
  });

  @override
  State<CommonSignupPage> createState() => _CommonSignupPageState();
}

class _CommonSignupPageState extends State<CommonSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final apiClient = AuthApiClient();
  final storage = const FlutterSecureStorage();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String email = emailController.text;
    String password = passwordController.text;
    String nickName = textController.text;

    try {
      final LoginResponse response;

      if (widget.store == null) {
        // 구매자 회원가입
        RegisterBuyerRequest request = RegisterBuyerRequest(
          email: email,
          password: password,
          nickName: nickName,
        );
        response = (await apiClient.authRegisterBuyer(request: request));
      } else {
        // 판매자 회원가입
        RegisterSellerRequest request = RegisterSellerRequest(
          email: email,
          password: password,
          nickName: nickName,
          store: widget.store!,
        );
        response = (await apiClient.authRegisterSeller(request: request));
      }

      if (response.success && response.data != null) {
        final data = response.data!;
        final user = data.user;

        await storage.write(key: 'ACCESS_TOKEN', value: data.accessToken);
        await storage.write(key: 'REFRESH_TOKEN', value: data.refreshToken);
        await storage.write(key: 'USER_ID', value: user.id);

        if (user.nickName != null) {
          await storage.write(key: 'USER_NICKNAME', value: user.nickName!);
        }

        if (user.companyId != null) {
          await storage.write(key: 'COMPANY_CODE', value: user.companyId!);
        }

        final roles = user.platformRoles ?? [];
        String userRole = 'buyer';
        if (roles.contains('seller')) {
          userRole = 'seller';
        }
        await storage.write(key: 'USER_ROLE', value: userRole);

        Fluttertoast.showToast(msg: "회원가입 및 로그인이 완료되었습니다.");

        if (mounted) {
          context.go('/');
        }
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      String errorMessage = "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.";

      final responseBody = e.response?.data;
      if (responseBody != null && responseBody is Map && responseBody['message'] != null) {
        errorMessage = responseBody['message'];
      } else {
        switch (statusCode) {
          case 400:
            errorMessage = "입력값을 확인해주세요.";
            break;
          case 409:
            errorMessage = "이미 가입된 이메일입니다.";
            break;
        }
      }
      Fluttertoast.showToast(msg: errorMessage);
      print("[SIGNUP ERROR] ${e.message} / $statusCode");
    } catch (e, s) {
      Fluttertoast.showToast(msg: "알 수 없는 오류가 발생했습니다. 개발자에게 문의해주세요.");
      print("[UNEXPECTED SIGNUP ERROR] ${e.toString()}");
      print(s);
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
            Text(l10n.signInTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(width: 10),
            Text("공통", style: TextStyle(color: AppColors.primarySub, fontSize: 18)),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.6),
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
                        if (value.length < 6) return '비밀번호는 6자리 이상이여야 합니다';
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
                        if (passwordController.text != value) return '입력한 비밀번호가 서로 다릅니다';
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    LoginTextField(
                      controller: emailController,
                      labelText: l10n.loginEmailTitle,
                      hintText: l10n.loginEmailInputHint,
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        if (value == null || value.isEmpty) return '내용을 입력해주세요';
                        if (!regExp.hasMatch(value)) return '잘못된 이메일 형식입니다';
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
        padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: BottomButton(
          buttonText: l10n.signInTitle,
          pressedFunc: _submit,
        ),
      ),
    );
  }
}