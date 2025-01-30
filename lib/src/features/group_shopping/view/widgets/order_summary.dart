import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/purchase_history/view/widget/summary_text_widget.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class GroupCheckoutSummary extends StatelessWidget {
  const GroupCheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final shippingCost = Get.parameters["shipping_charge"];
    final groupPrice = Get.parameters["group_price"];
    return AppCardContainer(
          applyRadius: false,
          backgroundColor: AppColors.white,
          child: Column(
            children: [
              AppSummaryTextWidget(
                  title: 'Subtotal',
                  amount: '৳$groupPrice'),
              const Gap(AppSizes.sm),
              AppSummaryTextWidget(
                  title: 'Shipping Cost',
                  amount: '৳$shippingCost'),
              const Gap(AppSizes.sm),
              AppSummaryTextWidget(
                  title: 'Total',
                  amount:
                  '৳${int.parse(shippingCost!) + int.parse(groupPrice!)}'),
            ],
          ));
  }
}