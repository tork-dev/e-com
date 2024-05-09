import 'package:flutter/material.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';


class AppPriceFilterField extends StatelessWidget {
  const AppPriceFilterField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 100,
      child: TextField(
        cursorColor: AppColors.primary,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Minimum',
            hintStyle: Theme.of(context).textTheme.labelSmall!.apply(color: AppColors.lightGrey),
            contentPadding: const EdgeInsets.only(left: AppSizes.sm),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey))
        ),
      ),
    );
  }
}

