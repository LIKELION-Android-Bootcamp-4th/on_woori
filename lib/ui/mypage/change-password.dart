import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/admin_api_client.dart';
import 'package:on_woori/widgets/bottom_button.dart';

class PasswordEditPage extends StatefulWidget {
  final String userId;

  const PasswordEditPage({
    super.key,
    required this.userId,
  });

  @override
  State<PasswordEditPage> createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // API 클라이언트 인스턴스화
  final AdminApiClient _adminApiClient = AdminApiClient();

  // UI 상태 관리를 위한 변수
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    setState(() {
      _errorMessage = null;

      final currentPwd = currentPasswordController.text;
      final newPwd = newPasswordController.text;
      final confirmPwd = confirmPasswordController.text;

      if (newPwd.isNotEmpty) {
        if (newPwd.length < 6) {
          _errorMessage = '새 비밀번호는 최소 6자리 이상이어야 합니다.';
        } else if (newPwd == currentPwd) {
          _errorMessage = '새 비밀번호는 현재 비밀번호와 달라야 합니다.';
        }
      }

      if (confirmPwd.isNotEmpty && newPwd != confirmPwd) {
        _errorMessage = '새 비밀번호가 일치하지 않습니다.';
      }
    });
  }

  // 저장 버튼 활성화 조건을 결정하는 함수
  bool _isSaveEnabled() {
    return currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        !_isLoading &&
        _errorMessage == null;
  }

  // '비밀번호 변경' 버튼을 눌렀을 때 실행되는 함수
  Future<void> _onSave() async {
    _validateInputs();
    if (_errorMessage != null) {
      Fluttertoast.showToast(msg: _errorMessage!);
      return;
    }
    // ✨ 위젯에 전달된 userId가 비어있는지 확인
    if (widget.userId.isEmpty) {
      Fluttertoast.showToast(msg: '사용자 정보가 올바르지 않습니다.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _adminApiClient.loginAsAdmin();

      await _adminApiClient.changePassword(
        id: widget.userId,
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );

      Fluttertoast.showToast(msg: '비밀번호가 성공적으로 변경되었습니다.');
      if (mounted) {
        context.pop();
      }

    } on DioException catch (e) {
      String serverMsg = '비밀번호 변경에 실패했습니다. 다시 시도해주세요.';
      if (e.response?.data is Map) {
        serverMsg = e.response?.data['message'] ?? serverMsg;
      }
      Fluttertoast.showToast(msg: serverMsg);
    } catch (e) {
      Fluttertoast.showToast(msg: '알 수 없는 오류가 발생했습니다.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '비밀번호 수정',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('현재 비밀번호'),
            const SizedBox(height: 5),
            _buildPasswordField(currentPasswordController, _obscureCurrent, () {
              setState(() => _obscureCurrent = !_obscureCurrent);
            }),
            const SizedBox(height: 20),
            _buildLabel('새 비밀번호'),
            const SizedBox(height: 5),
            _buildPasswordField(newPasswordController, _obscureNew, () {
              setState(() => _obscureNew = !_obscureNew);
            }),
            const SizedBox(height: 20),
            _buildLabel('비밀번호 확인'),
            const SizedBox(height: 5),
            _buildPasswordField(confirmPasswordController, _obscureConfirm, () {
              setState(() => _obscureConfirm = !_obscureConfirm);
            }),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
            const SizedBox(height: 30),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : BottomButton(
              buttonText: '비밀번호 변경',
              pressedFunc: _isSaveEnabled() ? _onSave : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller,
      bool obscure,
      VoidCallback toggle,
      ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: (_) => _validateInputs(),
      decoration: InputDecoration(
        hintText: '비밀번호 입력',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.dividerTextBoxLineDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.dividerTextBoxLineDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.grey,
          ),
          onPressed: toggle,
        ),
      ),
    );
  }
}
