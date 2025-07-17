import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/styles/app_colors.dart';

class BottomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? pressedFunc;

  const BottomButton({required this.buttonText, this.pressedFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ElevatedButton(
        onPressed: pressedFunc,
        // endregion
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primarySub,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
