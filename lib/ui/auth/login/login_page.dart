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

        Fluttertoast.showToast(msg: "로그인 되었습니다.");
        context.go('/');
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      switch (statusCode) {
        case 400:
          Fluttertoast.showToast(msg: "요청이 잘못되었습니다.");
          break;
        case 401:
          Fluttertoast.showToast(msg: "이메일 또는 비밀번호가 일치하지 않습니다.");
          break;
        case 403:
          Fluttertoast.showToast(msg: "계정이 비활성화되었거나 인증되지 않았습니다.");
          break;
        default:
          Fluttertoast.showToast(msg: "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
          break;
      }
      debugPrint("[LOGIN ERROR] ${e.message} / $statusCode");
    } catch (e) {
      Fluttertoast.showToast(msg: "예상치 못한 오류가 발생했습니다.");
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
                    "https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 1, // 나머지 절반
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.loginTitle,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 20),
                        LoginTextField(
                          controller: emailController,
                          labelText: l10n.loginEmailTitle,
                          hintText: l10n.loginEmailInputHint,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        LoginTextField(
                          controller: passwordController,
                          labelText: l10n.loginPasswordTitle,
                          hintText: l10n.loginPasswordInputHint,
                          inputType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),
                        BottomButton(
                          buttonText: l10n.loginTitle,
                          pressedFunc: () {
                            _submit();
                          },
                        ),
                        Row(
                          children: <Widget>[
                            const Spacer(),
                            const Text(
                              "온우리가 처음이신가요?  ",
                              style: TextStyle(color: AppColors.grey),
                            ),
                            InkWell(
                              child: Text(
                                l10n.signInTitle,
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
                        const SizedBox(height: 50),
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
