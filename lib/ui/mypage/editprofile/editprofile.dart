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
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailAddressController = TextEditingController();

  String _selectedGender = '여성';

  @override
  void initState() {
    super.initState();
    _nicknameController.text = '멋쟁이 사자';
    _nameController.text = '안현진';
    _phoneController.text = '01012334531';
    _addressController.text = '서울 종로구 종로3길 17 DE타워 D1동 16,';
    _detailAddressController.text = '17층, 세렝게티';
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _detailAddressController.dispose();
    super.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('닉네임'),
            _buildTextField(_nicknameController),

            const SizedBox(height: 16),
            _buildLabel('성함'),
            _buildTextField(_nameController),

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
            _buildTextField(_phoneController, keyboardType: TextInputType.phone),

            const SizedBox(height: 16),
            _buildLabel('주소'),
            _buildTextField(_addressController),

            const SizedBox(height: 16),
            _buildLabel('상세주소'),
            _buildTextField(_detailAddressController),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomButton(
            buttonText: '저장',
            pressedFunc: () {
              // TODO: 저장 후 이동 처리
            },
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

  Widget _buildTextField(
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      children: [
        const SizedBox(height: 4),
        TextField(
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
        ),
      ],
    );
  }
}
