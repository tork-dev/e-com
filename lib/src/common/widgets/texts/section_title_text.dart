import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../containers/card_container.dart';

class AppSectionTitleText extends StatelessWidget {
  const AppSectionTitleText({
    required this.sectionTitle,
    this.buttonTxt = 'See all',
    this.flashTime,
    this.haveTxtButton = true,
    this.showCountDown = false,
    this.onTapSeeAll,
    super.key,
  });

  final String sectionTitle, buttonTxt;
  final bool haveTxtButton, showCountDown;
  final VoidCallback? onTapSeeAll;
  final DateTime? flashTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Visibility(
              visible: haveTxtButton,
              child: InkWell(
                onTap: onTapSeeAll,
                child: Text(
                  buttonTxt,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.apply(color: AppColors.darkGrey),
                ),
              ),
            ),
            Visibility(
              visible: showCountDown,
              child: AppCardContainer(
                backgroundColor: AppColors.primary,
                borderRadius: AppSizes.borderRadiusMd,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.sm,
                  horizontal: AppSizes.md,
                ),
                child: TimerCountdown(
                  format: CountDownTimerFormat.daysHoursMinutesSeconds,
                  descriptionTextStyle: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(
                    fontSize: AppSizes.fontSizeMSm,
                    color: AppColors.textWhite,
                    height: 1,
                  ),
                  timeTextStyle: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(
                    fontSize: AppSizes.fontSizeMSm,
                    color: AppColors.textWhite,
                    height: .5,
                  ),
                  colonsTextStyle: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(
                    fontSize: AppSizes.fontSizeMSm,
                    color: AppColors.textWhite,
                  ),
                  enableDescriptions: true,
                  daysDescription: 'Days',
                  hoursDescription: 'Hours',
                  minutesDescription: 'Mins',
                  secondsDescription: 'Secs',
                  spacerWidth: AppSizes.sm,
                  endTime: flashTime?? DateTime.now().add(const Duration(days: 1)),
                  onEnd: () {
                    print("Timer finished");
                  },
                ),
              ),
            ),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),
      ],
    );
  }
}
