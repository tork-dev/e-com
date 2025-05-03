import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../containers/card_container.dart';

class AppSectionTitleText extends StatelessWidget {
  const AppSectionTitleText(
      {required this.sectionTitle,
      this.buttonTxt = 'See all',
      this.haveTxtButton = true,
        this.showCountDown = false,
      this.onTapSeeAll,
      super.key});

  final String sectionTitle, buttonTxt;
  final bool haveTxtButton, showCountDown;
  final VoidCallback? onTapSeeAll;

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
                  child: Text(buttonTxt,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: AppColors.darkGrey))),
            ),
            Visibility(
              visible: showCountDown,
              child: AppCardContainer(
                backgroundColor: AppColors.primary,
                borderRadius: AppSizes.borderRadiusSm,
                padding:
                const EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.md),
                child: TimerCountdown(
                  format: CountDownTimerFormat
                      .daysHoursMinutesSeconds,
                  descriptionTextStyle: Theme.of(
                      context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                      fontSize: AppSizes.fontSizeMSm,
                      color: AppColors.textWhite),
                  timeTextStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                      fontSize: AppSizes.fontSizeMSm,
                      color: AppColors.textWhite),
                  colonsTextStyle: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(
                      fontSize: 0,
                      color: AppColors.textPrimary),
                  daysDescription: 'Day',
                  hoursDescription: 'Hour',
                  minutesDescription: 'Min',
                  secondsDescription: 'Sec',
                  spacerWidth: 5,
                  endTime: DateTime.parse("2026-10-26"),
                  onEnd: () {
                    print("Timer finished");
                  },
                ),
              ),
            ),
          ],
        ),
        const Gap(AppSizes.sm)
      ],
    );
  }
}
