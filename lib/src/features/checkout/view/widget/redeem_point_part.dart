import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/checkout/controller/checkout_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class RedeemPointPart extends StatelessWidget {
  const RedeemPointPart({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    return AppCardContainer(
        backgroundColor: AppColors.white,
        padding: const EdgeInsets.all(AppSizes.md),
        child: Obx( () {
            return Row(
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
                      "${checkoutController.rewardBalance} Points",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                 InkWell(
                    onTap: () {
                      checkoutController.rewardBalance.value > 99
                          ? checkoutController.pointRedeemAlert()
                          // checkoutController.pointRedeemAlert();
                          : AppHelperFunctions.showToast(
                              'You have not enough points');
                    },
                    child: Text(
                      "redeem points".toUpperCase(),
                      style: TextStyle(
                        shadows: [
                          Shadow(
                              color: checkoutController.rewardBalance.value > 99
                                  ? AppColors.primary
                                  : AppColors.grey,
                              offset: const Offset(0, -4))
                        ],
                        fontSize: 16,
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            checkoutController.rewardBalance.value > 99
                                ? AppColors.primary
                                : AppColors.grey,
                        decorationThickness: AppSizes.xs,
                      ),
                    ),
                  )

              ],
            );
          }
        ));
  }
}
