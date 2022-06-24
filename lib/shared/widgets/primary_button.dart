import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    this.buttonColor = AppColors.secondaryColor,
    this.borderRadius = 8.0,
  }) : super(key: key);
  final Function(Function, Function, ButtonState) onTap;
  final String buttonTitle;
  final Color buttonColor;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 49,
      width: 170,
      borderRadius: borderRadius,
      color: buttonColor,
      loader: Container(
        padding: const EdgeInsets.all(10),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
      onTap: onTap,
      child: Text(
        buttonTitle,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
    );
  }
}
