import 'package:flutter/material.dart';

import '../core/styles/app_colors.dart';

class LoginTextField extends StatelessWidget {
  String labelText;
  String hintText;

  LoginTextField({required this.labelText, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: AppColors.primarySub),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.redAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.redAccent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}