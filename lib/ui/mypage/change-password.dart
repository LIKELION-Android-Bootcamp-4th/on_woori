import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/widgets/bottom_button.dart';

class PasswordEditPage extends StatefulWidget {
  const PasswordEditPage({super.key});

  @override
  State<PasswordEditPage> createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  String? _errorMessage;

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

      String currentPwd = currentPasswordController.text.trim();
      String newPwd = newPasswordController.text.trim();
      String confirm = confirmPasswordController.text.trim();

      if (newPwd.isEmpty) {
        return;
      }

      if (newPwd.length < 6) {
        _errorMessage = '새 비밀번호는 최소 6자리 이상이어야 합니다.';
        return;
      }

      if (newPwd == currentPwd) {
        _errorMessage = '새 비밀번호는 현재 비밀번호와 달라야 합니다.';
        return;
      }

      if (confirm.isNotEmpty && newPwd != confirm) {
        _errorMessage = '새 비밀번호가 일치하지 않습니다.';
        return;
      }
    });
  }

  void _onSave() {
    _validateInputs();

    if (_errorMessage == null) {
      ///TODO: 저장 처리
      context.go('/mypage');
    }
  }

  bool _isSaveEnabled() {
    final currentPwd = currentPasswordController.text.trim();
    return currentPwd.length >= 6 && _errorMessage == null;
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
            const SizedBox(height: 5,),
            _buildPasswordField(currentPasswordController, _obscureCurrent, () {
              setState(() {
                _obscureCurrent = !_obscureCurrent;
                _validateInputs();
              });
            }),

            const SizedBox(height: 20),

            _buildLabel('새 비밀번호'),
            const SizedBox(height: 5,),
            _buildPasswordField(newPasswordController, _obscureNew, () {
              setState(() {
                _obscureNew = !_obscureNew;
                _validateInputs();
              });
            }),

            const SizedBox(height: 20),

            _buildLabel('비밀번호 확인'),
            const SizedBox(height: 5,),
            _buildPasswordField(confirmPasswordController, _obscureConfirm, () {
              setState(() {
                _obscureConfirm = !_obscureConfirm;
                _validateInputs();
              });
            }),

            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.blue, fontSize: 13),
                ),
              ),

            const SizedBox(height: 30),

            BottomButton(
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
          borderSide: const BorderSide(color: AppColors.DividerTextBoxLineDivider),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.grey,
          ),
          onPressed: toggle,
        )
            : null,
      ),
    );
  }
}
