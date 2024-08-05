import 'package:flutter/material.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';

class TroubleChecklist extends StatelessWidget {
  const TroubleChecklist(
      {required this.title, required this.onChanged, required this.value, super.key});

  final String title;
  final dynamic onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return  Row(
        children: [
          Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: value,
              onChanged: onChanged
              ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.apply(
                color: value
                    ? AppColors.primary
                    : isDark
                        ? AppColors.light
                        : AppColors.dark),
          )
        ],
    );
  }
}
