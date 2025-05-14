import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/reward_point/controller/reward_controller.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_instruction_card_list.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_top_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';


class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.put(RewardController());
    return AppLayoutWithBackButton(
        leadingIconColor: AppColors.white,
        backgroundColor: AppColors.primary,
        padding: AppSizes.md,
        title:
            const Text('Rewards', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
        body: AppLayoutWithRefresher(
            onRefresh: rewardController.onRefresh,
            children:  const [
              Gap(AppSizes.lg),
              RewardTopCard(),
              Gap(AppSizes.spaceBtwItems),
              RewardInstructionCardList(),
              Gap(AppSizes.spaceBtwSections),
              // AppButtons.largeFlatFilledButton(
              //   backgroundColor: AppColors.secondary,
              //     onPressed: (){
              //     Get.toNamed('/point-redemption');
              //     },
              //     buttonText: 'REDEEM POINTS'),
              Gap(AppSizes.spaceBtwSections)
            ]));
  }
}


