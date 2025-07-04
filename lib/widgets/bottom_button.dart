import 'package:flutter/material.dart';

import '../core/styles/app_colors.dart';

class BottomButton extends StatelessWidget {
  String buttonText;
  VoidCallback? pressedFunc;

  BottomButton({required this.buttonText, required this.pressedFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ElevatedButton(
        onPressed: pressedFunc,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primarySub,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            )
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}