import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';

class AuthInputField extends StatelessWidget {
  const AuthInputField({
    super.key,
    this.isDark = false,
    required this.hingText,
    required this.controller,
    required this.obscured,
    required this.validator,
    this.suffixIcon,
  });

  final bool isDark, obscured;
  final String hingText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscured,
      decoration: InputDecoration(
        hintText: hingText,
        suffixIcon: suffixIcon,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.primary,
            )
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.darkGrey,
            )
        ),
        hintStyle: const TextStyle(
          color: AppColors.lightGrey,
        )
        // focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(
        //         color: isDark ? AppColors.white : AppColors.darkGrey)),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: BorderSide(
        //         color: isDark ? AppColors.lightGrey : AppColors.grey)),
        // errorBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.error)),
        // focusedErrorBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.error)),
      ),
    );
  }
}
