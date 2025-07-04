import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/widgets/bottom_button.dart';

class EditProfileSellerPage extends StatefulWidget {
  const EditProfileSellerPage({super.key});

  @override
  State<EditProfileSellerPage> createState() => _EditProfileSellerPageState();
}

class _EditProfileSellerPageState extends State<EditProfileSellerPage> {
  final TextEditingController _managerController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _managerController.text = '신서진';
    _phoneController.text = '01051797631';
    _addressController.text = '서울 종로구 종로3길 17 D타워 D1동 16,';
    _detailAddressController.text = '17층, 세렝게티';
  }

  @override
  void dispose() {
    _managerController.dispose();
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
            _buildLabel('담당자명'),
            _buildTextField(_managerController),

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
              // TODO: 저장 처리
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
