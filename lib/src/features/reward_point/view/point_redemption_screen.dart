import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/reward_point/controller/point_redeem_controller.dart';
import 'package:kirei/src/features/reward_point/view/widgets/point_redemption_products.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class PointRedemption extends StatelessWidget {
  const PointRedemption({super.key});

  @override
  Widget build(BuildContext context) {
    final redeemController = Get.put(PointRedeemController());
    return AppLayoutWithBackButton(
        padding: AppSizes.md,
        title: const Text(
          'Point Redemption',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        body: AppLayoutWithRefresher(
          onRefresh: redeemController.onRefresh,
          children: const [PointRedemptionProducts()],
        ));
  }
}
