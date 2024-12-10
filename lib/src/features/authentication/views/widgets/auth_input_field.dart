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
    this.enableTextField = true
  });

  final bool isDark, obscured, enableTextField;
  final String hingText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final dynamic validator;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscured,
      cursorColor: AppColors.primary,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hingText,
        suffix: suffixIcon,
        //suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.only(left: AppSizes.sm),
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
        ),
        enabled: enableTextField
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
