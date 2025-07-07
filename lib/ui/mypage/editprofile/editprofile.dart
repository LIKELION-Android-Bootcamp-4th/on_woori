import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/dropdown.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailAddressController = TextEditingController();

  String _selectedGender = '여성';

  @override
  void initState() {
    super.initState();
    _nicknameController.text = '멋쟁이 사자';
    _nameController.text = '안현진';
    _phoneController.text = '01012334531';
    _zipcodeController.text = '12345';
    _addressController.text = '서울 종로구 종로3길 17 DE타워 D1동 16,';
    _detailAddressController.text = '17층, 세렝게티';
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _zipcodeController.dispose();
    _addressController.dispose();
    _detailAddressController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: 저장 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('닉네임'),
              _buildTextFormField(_nicknameController, validatorText: '닉네임을 입력해주세요'),

              const SizedBox(height: 16),
              _buildLabel('성함'),
              _buildTextFormField(_nameController, validatorText: '성함을 입력해주세요'),

              const SizedBox(height: 16),
              _buildLabel('성별'),
              const SizedBox(height: 8),
              CustomDropdown(
                selectedValue: _selectedGender,
                items: ['여성', '남성', '선택하지않음'],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),

              const SizedBox(height: 16),
              _buildLabel('전화번호'),
              _buildTextFormField(
                _phoneController,
                keyboardType: TextInputType.phone,
                validatorText: '전화번호를 입력해주세요',
              ),

              const SizedBox(height: 16),
              _buildLabel('우편번호'),
              _buildTextFormField(
                _zipcodeController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '우편번호를 입력해주세요';
                  }
                  if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                    return '우편번호는 5자리 숫자로 입력해주세요';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              _buildLabel('주소'),
              _buildTextFormField(_addressController, validatorText: '주소를 입력해주세요'),

              const SizedBox(height: 16),
              _buildLabel('상세주소'),
              _buildTextFormField(_detailAddressController, validatorText: '상세주소를 입력해주세요'),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(
            buttonText: '저장',
            pressedFunc: _submit,
          ),
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
    return Column(
      children: [
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.DividerTextBoxLineDivider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.DividerTextBoxLineDivider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.DividerTextBoxLineDivider),
            ),
          ),
          validator: validator ??
                  (value) {
                if (value == null || value.isEmpty) {
                  return validatorText ?? '내용을 입력해주세요';
                }
                return null;
              },
        ),
      ],
    );
  }
}
