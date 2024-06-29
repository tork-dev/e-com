import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class LinearProgressSection extends StatelessWidget {
  final double linearPercent;
  final String linearPercentString;
  const LinearProgressSection({
    super.key, required this.linearPercent, required this.linearPercentString,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearPercentIndicator(
          width: AppHelperFunctions.screenWidth(),
          lineHeight: AppSizes.sm,
          percent: linearPercent,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.grey[350],
          progressColor: AppColors.secondary,
        ),
        const Gap(AppSizes.sm),
        Text(linearPercentString, style: Theme.of(context).textTheme.titleMedium,)
      ],
    );
  }
}