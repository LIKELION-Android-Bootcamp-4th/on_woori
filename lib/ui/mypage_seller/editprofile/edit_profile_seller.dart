import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/bottom_button.dart';

class EditProfileSellerPage extends StatefulWidget {
  const EditProfileSellerPage({super.key});

  @override
  State<EditProfileSellerPage> createState() => _EditProfileSellerPageState();
}

class _EditProfileSellerPageState extends State<EditProfileSellerPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _managerController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailAddressController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    // TODO: 서버에서 판매자 프로필 정보 가져오기
    _managerController.text = '신서진';
    _phoneController.text = '01051797631';
    _zipcodeController.text = '12345';
    _addressController.text = '서울 종로구 종로3길 17 D타워 D1동 16,';
    _detailAddressController.text = '17층, 세렝게티';
  }

  @override
  void dispose() {
    _managerController.dispose();
    _phoneController.dispose();
    _zipcodeController.dispose();
    _addressController.dispose();
    _detailAddressController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: 서버에 수정 내용 전송
      debugPrint('=== 저장할 정보 ===');
      debugPrint('담당자명: ${_managerController.text}');
      debugPrint('전화번호: ${_phoneController.text}');
      debugPrint('우편번호: ${_zipcodeController.text}');
      debugPrint('주소: ${_addressController.text}');
      debugPrint('상세주소: ${_detailAddressController.text}');
      debugPrint('==================');

      if (!mounted) return;
      context.go('/mypage/seller');
    }
  }

  void _onBackPressed() {
    // TODO: 필요하면 저장 여부 확인 다이얼로그 띄우기
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: _onBackPressed,
        ),
        title: Text(
          l10n.editProfileSellerPageTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(l10n.editProfileSellerManagerLabel),
              const SizedBox(height: 5),
              _buildTextFormField(
                _managerController,
                validatorText: l10n.editProfileSellerManagerHint,
              ),
              const SizedBox(height: 16),
              _buildLabel(l10n.editProfileSellerPhoneLabel),
              const SizedBox(height: 5),
              _buildTextFormField(
                _phoneController,
                keyboardType: TextInputType.phone,
                validatorText: l10n.editProfileSellerPhoneHint,
              ),
              const SizedBox(height: 16),
              _buildLabel(l10n.editProfileSellerZipcodeLabel),
              const SizedBox(height: 5),
              _buildTextFormField(
                _zipcodeController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.editProfileSellerZipcodeHint;
                  }
                  if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                    return l10n.editProfileSellerZipcodeInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildLabel(l10n.editProfileSellerAddressLabel),
              const SizedBox(height: 5),
              _buildTextFormField(
                _addressController,
                validatorText: l10n.editProfileSellerAddressHint,
              ),
              const SizedBox(height: 16),
              _buildLabel(l10n.editProfileSellerDetailAddressLabel),
              const SizedBox(height: 5),
              _buildTextFormField(
                _detailAddressController,
                validatorText: l10n.editProfileSellerDetailAddressHint,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(
              buttonText: l10n.editProfileSellerSaveButton,
              pressedFunc: _submit),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        String? validatorText,
        String? Function(String?)? validator,
      }) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.dividerTextBoxLineDivider,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.dividerTextBoxLineDivider,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.dividerTextBoxLineDivider,
              ),
            ),
          ),
          validator: validator ??
                  (value) {
                if (value == null || value.isEmpty) {
                  return validatorText ?? l10n.validatorRequired;
                }
                return null;
              },
        ),
      ],
    );
  }
}
