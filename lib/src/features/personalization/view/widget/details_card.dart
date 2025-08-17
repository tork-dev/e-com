import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';


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
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cardText, style: Theme.of(context).textTheme.titleMedium!.apply(color: AppColors.darkGrey),),
          const Gap(AppSizes.sm),
          AppDividersStyle.fullFlatAppDivider
        ],
      ),
    );
  }
}
