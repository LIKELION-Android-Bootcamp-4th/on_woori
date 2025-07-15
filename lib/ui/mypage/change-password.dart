import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/admin_api_client.dart';
import 'package:on_woori/l10n/app_localizations.dart';
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
  final TextEditingController currentPasswordController =
  TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  final AdminApiClient _adminApiClient = AdminApiClient();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _errorMessage = null;

      final currentPwd = currentPasswordController.text;
      final newPwd = newPasswordController.text;
      final confirmPwd = confirmPasswordController.text;

      if (newPwd.isNotEmpty) {
        if (newPwd.length < 6) {
          _errorMessage = l10n.passwordEditErrorLength;
        } else if (newPwd == currentPwd) {
          _errorMessage = l10n.passwordEditErrorSameAsCurrent;
        }
      }

      if (confirmPwd.isNotEmpty && newPwd != confirmPwd) {
        _errorMessage = l10n.passwordEditErrorMismatch;
      }
    });
  }

  bool _isSaveEnabled() {
    return currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        !_isLoading &&
        _errorMessage == null;
  }

  Future<void> _onSave() async {
    final l10n = AppLocalizations.of(context)!;
    _validateInputs();
    if (_errorMessage != null) {
      Fluttertoast.showToast(msg: _errorMessage!);
      return;
    }

    if (widget.userId.isEmpty) {
      Fluttertoast.showToast(msg: l10n.passwordEditErrorInvalidUser);
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

      Fluttertoast.showToast(msg: l10n.passwordEditSuccess);
      if (mounted) {
        context.pop();
      }
    } on DioException catch (e) {
      String serverMsg = l10n.passwordEditErrorFailed;
      if (e.response?.data is Map) {
        serverMsg = e.response?.data['message'] ?? serverMsg;
      }
      Fluttertoast.showToast(msg: serverMsg);
    } catch (e) {
      Fluttertoast.showToast(msg: l10n.passwordEditErrorUnexpected);
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.passwordEditPageTitle,
          style: const TextStyle(
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
            _buildLabel(l10n.passwordEditCurrentPasswordLabel),
            const SizedBox(height: 5),
            _buildPasswordField(
              controller: currentPasswordController,
              obscure: _obscureCurrent,
              toggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
              hintText: l10n.passwordEditHint,
            ),
            const SizedBox(height: 20),
            _buildLabel(l10n.passwordEditNewPasswordLabel),
            const SizedBox(height: 5),
            _buildPasswordField(
              controller: newPasswordController,
              obscure: _obscureNew,
              toggle: () => setState(() => _obscureNew = !_obscureNew),
              hintText: l10n.passwordEditHint,
            ),
            const SizedBox(height: 20),
            _buildLabel(l10n.passwordEditConfirmPasswordLabel),
            const SizedBox(height: 5),
            _buildPasswordField(
              controller: confirmPasswordController,
              obscure: _obscureConfirm,
              toggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
              hintText: l10n.passwordEditHint,
            ),
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
              buttonText: l10n.passwordEditButton,
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: (_) => _validateInputs(),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          const BorderSide(color: AppColors.dividerTextBoxLineDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          const BorderSide(color: AppColors.dividerTextBoxLineDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
