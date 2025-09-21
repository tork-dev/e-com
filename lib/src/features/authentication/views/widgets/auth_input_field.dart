import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';

class AuthInputField extends StatelessWidget {
  const AuthInputField({
    super.key,
    this.isDark = false,
    required this.hingText,
    required this.controller,
    required this.obscured,
    this.validator,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.enableTextField = true,
    this.autofillHints
  });

  final bool isDark, obscured, enableTextField;
  final String hingText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final dynamic validator;
  final TextInputType textInputType;
  final List<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscured,
      cursorColor: AppColors.primary,
      keyboardType: textInputType,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        hintText: hingText,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
          borderSide: BorderSide(width: 1, color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
          borderSide: BorderSide(width: 1, color: AppColors.lightGrey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
          borderSide: BorderSide(width: 1, color: AppColors.lightGrey),
        ),
        hintStyle: const TextStyle(color: AppColors.darkGrey),
        enabled: enableTextField,
        fillColor: AppColors.white,
        filled: true,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
            borderSide: BorderSide(width:1, color: AppColors.error)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
            borderSide: BorderSide(width:1, color: AppColors.error)),
      ),
    );
  }
}
