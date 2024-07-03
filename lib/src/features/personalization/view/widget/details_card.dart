import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class DetailsCard extends StatelessWidget {
  final String cardText;
  final Color? cardColor;
  final dynamic onTap;

  const DetailsCard(
      {super.key,
      required this.cardText,
      required this.onTap,
      this.cardColor});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cardText, style: Theme.of(context).textTheme.titleLarge!.apply(color: AppColors.darkGrey),),
          const Gap(AppSizes.sm),
          AppDividersStyle.fullFlatAppDivider
        ],
      ),
    );
  }
}
