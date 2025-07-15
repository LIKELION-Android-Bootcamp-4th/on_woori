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

  const CommonSignupPage({this.store, super.key});

  @override
  State<CommonSignupPage> createState() => _CommonSignupPageState();
}

class _CommonSignupPageState extends State<CommonSignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
  TextEditingController();
  final AuthApiClient apiClient = AuthApiClient();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void _submit() async {
    final l10n = AppLocalizations.of(context)!;
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
        final LoginData data = response.data!;
        final UserData user = data.user;

        await storage.write(key: 'ACCESS_TOKEN', value: data.accessToken);
        await storage.write(key: 'REFRESH_TOKEN', value: data.refreshToken);
        await storage.write(key: 'USER_ID', value: user.id);

        if (user.nickName != null) {
          await storage.write(key: 'USER_NICKNAME', value: user.nickName!);
        }

        if (user.companyId != null) {
          await storage.write(key: 'COMPANY_CODE', value: user.companyId!);
        }

        final List<String> roles = user.platformRoles ?? <String>[];
        String userRole = 'buyer';
        if (roles.contains('seller')) {
          userRole = 'seller';
        }
        await storage.write(key: 'USER_ROLE', value: userRole);

        Fluttertoast.showToast(msg: l10n.signUpSuccess);

        if (mounted) {
          context.go('/');
        }
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      String errorMessage = l10n.signUpErrorServer;

      final responseBody = e.response?.data;
      if (responseBody != null &&
          responseBody is Map &&
          responseBody['message'] != null) {
        errorMessage = responseBody['message'];
      } else {
        switch (statusCode) {
          case 400:
            errorMessage = l10n.signUpErrorBadRequest;
            break;
          case 409:
            errorMessage = l10n.signUpErrorConflict;
            break;
        }
      }
      Fluttertoast.showToast(msg: errorMessage);
      debugPrint("[SIGNUP ERROR] ${e.message} / $statusCode");
    } catch (e, s) {
      Fluttertoast.showToast(msg: l10n.signUpErrorUnexpected);
      debugPrint("[UNEXPECTED SIGNUP ERROR] ${e.toString()}");
      debugPrint(s.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              l10n.signUpPageTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(width: 10),
            Text(
              l10n.signUpPageSubtitleCommon,
              style: const TextStyle(color: AppColors.primarySub, fontSize: 18),
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
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: <Widget>[
                    LoginTextField(
                      controller: textController,
                      labelText: l10n.signUpNicknameLabel,
                      hintText: l10n.signUpNicknameHint,
                      inputType: TextInputType.text,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) return l10n.validatorRequired;
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    LoginTextField(
                      controller: passwordController,
                      labelText: l10n.signUpPasswordLabel,
                      hintText: l10n.signUpPasswordHint,
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) return l10n.validatorRequired;
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    LoginTextField(
                      controller: passwordConfirmController,
                      labelText: l10n.signUpPasswordConfirmLabel,
                      hintText: l10n.signUpPasswordConfirmHint,
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (String? value) {
                        String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$';
                        RegExp regExp = RegExp(pattern);
                        if (value == null || value.isEmpty) return l10n.validatorRequired;
                        if (passwordController.text != value) return l10n.validatorPasswordMismatch;
                        if (!regExp.hasMatch(value)) return l10n.validatorPasswordInvalid;
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    LoginTextField(
                      controller: emailController,
                      labelText: l10n.loginEmailLabel,
                      hintText: l10n.loginEmailHint,
                      inputType: TextInputType.emailAddress,
                      validator: (String? value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        if (value == null || value.isEmpty) return l10n.validatorRequired;
                        if (!regExp.hasMatch(value)) return l10n.validatorEmailInvalid;
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
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: BottomButton(buttonText: l10n.signUpPageTitle, pressedFunc: _submit),
      ),
    );
  }
}
