import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';
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
  String _selectedGender = '여성';

  @override
  void initState() {
    super.initState();
    _nicknameController.text = '멋쟁이 사자';
    _nameController.text = '안현진';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 6),
            CustomDropdown(
              selectedValue: _selectedGender,
              items: ['여성', '남성', '선택하지않음'],
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),

            const Spacer(),

            BottomButton(buttonText: '저장', pressedFunc: () {},),
            // TODO: 저장 후 마이페이지로 이동하도록 구현
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
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Column(
      children: [
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.DividerTextBoxLineDivider),
            ),
          ),
        ),
      ],
    );
  }
}
