import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/containers/vertical_product_card.dart';
import 'package:kirei/src/features/reward_point/controller/point_redeem_controller.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_product_card.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../common/layouts/gridview_layout/gridview_layout.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../authentication/views/log_in/view/login.dart';
import '../../../cart/controllers/cart_controller.dart';

class PointRedemptionProducts extends StatelessWidget {
  const PointRedemptionProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final redeemProductController = PointRedeemController.instance;
    // final cartController = CartController.instance;
    return Obx(() {
      return AppGridViewLayout(
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
