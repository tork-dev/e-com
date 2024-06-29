import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class CircularProgressSection extends StatelessWidget {
  final String title;
  final double circlePercent;
  final bool isNotActive, isDone;

  const CircularProgressSection({
    super.key,
    required this.title,
    required this.circlePercent,
    this.isNotActive = true,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.sm, vertical: AppSizes.xs),
      backgroundColor: isNotActive ? AppColors.darkerGrey : AppColors.white,
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.apply(
                color: isNotActive ? AppColors.darkGrey : AppColors.secondary),
          ),
          const Gap(AppSizes.sm),
          isDone?
          const AppCardContainer(
            height: 20,
            width: 20,
            backgroundColor: AppColors.success,
            child: Center(child: Icon(Icons.check, size: 14, color: AppColors.white)),
          ) :
          CircularPercentIndicator(
            radius: 12,
            lineWidth: 3.0,
            percent: circlePercent,
            progressColor: AppColors.success,
            reverse: true,
            backgroundColor: isNotActive? AppColors.darkGrey : AppColors.lightGrey,
          ),
        ],
      ),
    );
  }
}