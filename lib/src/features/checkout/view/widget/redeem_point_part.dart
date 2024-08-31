import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/buttons/bottom_button.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class RedeemPointPart extends StatelessWidget {
  const RedeemPointPart({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        backgroundColor: AppColors.white,
        applyRadius: false,
        padding: const EdgeInsets.all(AppSizes.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Balance',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap(AppSizes.sm),
                Text(
                  "3000 Points",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            InkWell(
              onTap: (){
                AppHelperFunctions().pointRedeemAlert();
              },
              child: Text(
                "redeem point".toUpperCase(),
                style: const TextStyle(
                  shadows: [
                    Shadow(
                        color: Colors.red,
                        offset: Offset(0, -4))
                  ],
                  fontSize: 16,
                  color: Colors.transparent,
                  decoration:
                  TextDecoration.underline,
                  decorationColor: AppColors.primary,
                  decorationThickness: AppSizes.xs,
                ),
              ),
            )
          ],
        ));
  }
}
