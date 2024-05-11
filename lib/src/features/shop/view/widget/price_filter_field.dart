import 'package:flutter/material.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/validators/validation.dart';
import '../../../../utils/constants/colors.dart';


class AppPriceFilterField extends StatelessWidget {
  const AppPriceFilterField({super.key, required this.hintText, required this.controller});

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 100,
      child: TextFormField(
        cursorColor: AppColors.primary,
        keyboardType: TextInputType.number,
        controller: controller,
        //inputFormatters: [AppValidator.validateAmount(value)],
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall!.apply(color: AppColors.lightGrey),
            contentPadding: const EdgeInsets.only(left: AppSizes.sm),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
        ),
      ),
    );
  }
}

