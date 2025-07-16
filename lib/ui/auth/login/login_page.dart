import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/entity/request/auth/login_request.dart';
import 'package:on_woori/data/entity/response/auth/login_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/login_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageStatus();
}

class LoginPageStatus extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthApiClient apiClient = AuthApiClient();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void _submit() async {
    final l10n = AppLocalizations.of(context)!;
    String email = emailController.text;
    String password = passwordController.text;

    try {
      final LoginResponse response = await apiClient.authLogin(
        request: LoginRequest(email: email, password: password),
      );

      if (response.success && response.data != null) {
        // --- 🔽 토큰 및 사용자 정보 저장 로직 ---
        await storage.write(
          key: 'ACCESS_TOKEN',
          value: response.data!.accessToken,
        );
        await storage.write(
          key: 'REFRESH_TOKEN',
          value: response.data!.refreshToken,
        );
        await storage.write(key: 'USER_ID', value: response.data!.user.id);
        await storage.write(
          key: 'USER_NICKNAME',
          value: response.data!.user.nickName,
        );
        await storage.write(
          key: 'COMPANY_CODE',
          value: response.data!.user.companyId,
        );

        final List<String> roles =
            response.data!.user.platformRoles ?? <String>[];
        String userRole = 'buyer';
        if (roles.contains('seller')) {
          userRole = 'seller';
        }
        await storage.write(key: 'USER_ROLE', value: userRole);

        Fluttertoast.showToast(msg: l10n.loginSuccess);
        if (mounted) {
          context.go('/');
        }
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      String errorMessage;

      switch (statusCode) {
        case 400:
          errorMessage = l10n.loginErrorBadRequest;
          break;
        case 401:
          errorMessage = l10n.loginErrorUnauthorized;
          break;
        case 403:
          errorMessage = l10n.loginErrorForbidden;
          break;
        default:
          errorMessage = l10n.loginErrorServer;
          break;
      }
      Fluttertoast.showToast(msg: errorMessage);
      debugPrint("[LOGIN ERROR] ${e.message} / $statusCode");
    } catch (e) {
      Fluttertoast.showToast(msg: l10n.loginErrorUnexpected);
      debugPrint("[UNEXPECTED ERROR] ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.network(
                    l10n.dummyImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.loginPageTitle,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 20),
                        LoginTextField(
                          controller: emailController,
                          labelText: l10n.loginEmailLabel,
                          hintText: l10n.loginEmailHint,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        LoginTextField(
                          controller: passwordController,
                          labelText: l10n.loginPasswordLabel,
                          hintText: l10n.loginPasswordHint,
                          inputType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),
                        BottomButton(
                          buttonText: l10n.loginButton,
                          pressedFunc: () {
                            _submit();
                          },
                        ),
                        Row(
                          children: <Widget>[
                            const Spacer(),
                            Text(
                              l10n.loginPromptSignUp,
                              style: const TextStyle(color: AppColors.grey),
                            ),
                            InkWell(
                              child: Text(
                                l10n.signUpPageTitle,
                                style: const TextStyle(
                                  color: AppColors.primarySub,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                context.go("/auth/signup");
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
