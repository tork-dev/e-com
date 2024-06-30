import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppAddressTextField extends StatelessWidget {
  const AppAddressTextField({
    this.fieldTitle = '',
    required this.hintText,
    required this.controller,
    this.verticalPadding = 0,
    this.borderColor = AppColors.grey,
    this.borderWidth = 2,
    this.hasTitle = true,
    super.key});

  final String fieldTitle, hintText;
  final double  verticalPadding, borderWidth;
  final Color borderColor;
  final TextEditingController controller;
  final bool hasTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hasTitle? Text(fieldTitle, style: Theme.of(context).textTheme.bodySmall!) : const SizedBox(),
        const Gap(AppSizes.xs),
        SizedBox(
          //height: sizeBoxHeight,
          child: TextFormField(
            controller: controller,
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.symmetric(horizontal: 8, vertical: verticalPadding),
              hintText: hintText,
              hintStyle:  TextStyle(color: borderColor, fontWeight: FontWeight.w400),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: borderColor, width: borderWidth)
              ),
              focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: borderColor, width: borderWidth)
              ),
              enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: borderColor, width: borderWidth)
              ),
            ),
          ),
        ),
      ],
    );
  }
}

