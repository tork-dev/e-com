import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/reward_point/controller/point_redeem_controller.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_product_card.dart';
import '../../../../common/layouts/gridview_layout/gridview_layout.dart';

class PointRedemptionProducts extends StatelessWidget {
  const PointRedemptionProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final redeemProductController = PointRedeemController.instance;
    // final cartController = CartController.instance;
    return Obx(() {
      return AppGridViewLayout(
          mobileAspect: .60,
          tabletAspect: .60,
          desktopAspect: .60,
          itemCount: redeemProductController.hittingApi.value
              ? 10
              : redeemProductController
                  .pointRedemptionResponse.value.data!.length,
          builderFunction: (context, index) =>
              redeemProductController.hittingApi.value
                  ? ShimmerHelper().buildBasicShimmer(height: 150, width: 150)
                  : redeemProductController
                          .pointRedemptionResponse.value.data!.isEmpty
                      ? const Text('No Product Found')
                      : RewardProductCard(
                          index: index,));
    });
  }
}
