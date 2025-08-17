import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class KipCardWidget extends StatelessWidget {
  const KipCardWidget({
    super.key,
    required this.kipIcon,
    required this.kipTitle,
    required this.kipSubtitle,
    required this.pointQuantity,
    required this.kipMessage,
    required this.cardColor,
    required this.messageSideColor,
  });

  final String kipIcon, kipTitle, kipSubtitle, pointQuantity, kipMessage;
  final Color cardColor, messageSideColor;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        width: AppHelperFunctions.screenWidth(),
        padding: const EdgeInsets.all(AppSizes.md),
        backgroundColor: cardColor,
        child: Column(
          children: [
            AppCardContainer(
                height: 88,
                width: 88,
                backgroundColor: AppColors.white,
                padding: const EdgeInsets.all(AppSizes.md),
                isCircle: true,
                applyRadius: false,
                child: Image.asset(
                  kipIcon,
                  fit: BoxFit.cover,
                )),
            const Gap(AppSizes.md),
            Text(
              kipTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: AppColors.secondary),
            ),
            Text(
              kipSubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: AppColors.secondary),
            ),
            const Gap(AppSizes.md),
            AppDividersStyle.fullFlatAppDivider,
            const Gap(AppSizes.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Points: ',
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                      TextSpan(
                          text:
                              'Earn $pointQuantity point for every 100 BDT spent.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: AppColors.secondary))
                    ])),
                const Gap(AppSizes.sm),
                RichText(
                    text: TextSpan(
                        text: 'Value: ',
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                      TextSpan(
                          text: '1 point = 1BDT',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: AppColors.secondary))
                    ])),
                const Gap(AppSizes.defaultSpace),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        color: messageSideColor,
                      ),
                      const Gap(AppSizes.sm),
                      Expanded(
                        child: Text(
                          kipMessage,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: AppColors.secondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
