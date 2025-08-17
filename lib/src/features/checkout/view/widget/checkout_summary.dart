import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/checkout/controller/checkout_controller.dart';
import 'package:kirei/src/features/purchase_history/view/widget/summary_text_widget.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppCheckoutSummary extends StatelessWidget {
  const AppCheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    return Obx(() {
      return checkoutController.checkoutSummary.value.grandTotalValue == null
          ? ShimmerHelper().buildBasicShimmer(height: 150)
          : AppCardContainer(
              padding: const EdgeInsets.all(AppSizes.md),
              backgroundColor: AppColors.white,
              child: Column(
                children: [
                  AppSummaryTextWidget(
                      title: 'Subtotal',
                      amount:
                          '${checkoutController.checkoutSummary.value.subTotal}'),
                  const Gap(AppSizes.sm),
                  AppSummaryTextWidget(
                      title: 'Shipping Cost',
                      amount:
                          '${checkoutController.checkoutSummary.value.shippingCost}'),
                  const Gap(AppSizes.sm),
                  AppSummaryTextWidget(
                      title: 'Discount',
                      amount:
                          '${checkoutController.checkoutSummary.value.discount}'),
                  const Gap(AppSizes.sm),
                  Visibility(
                    visible: checkoutController.redeemedPoint > 99,
                    child: AppSummaryTextWidget(
                        title: 'Redeem Point',
                        amount: '৳${checkoutController.redeemedPoint}'),
                  ),
                  const Gap(AppSizes.sm),
                  AppSummaryTextWidget(
                      title: 'Total',
                      amount:
                          '৳${checkoutController.grandTotal.value}'),
                ],
              ));
    });
  }
}
