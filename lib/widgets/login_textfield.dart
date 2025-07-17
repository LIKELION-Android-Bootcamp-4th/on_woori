import 'package:flutter/material.dart';

import '../core/styles/app_colors.dart';

class LoginTextField extends StatelessWidget {
  String labelText;
  String hintText;
  TextInputType inputType;
  bool isPassword;
  TextEditingController? controller;
  String? Function(String?)? validator;

  LoginTextField({
    required this.labelText,
    required this.hintText,
    required this.inputType,
    this.controller,
    this.validator,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: AppColors.primarySub),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: Colors.redAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: Colors.redAccent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        errorStyle: TextStyle(
          color: AppColors.editDeleteTextButton,
          fontSize: 12,
        ),
      ),
      keyboardType: inputType,
    );
  }
}
