import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/reward_point/controller/reward_controller.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_instruction_card_list.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_top_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'widgets/reward_instruction_card.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.put(RewardController());
    return AppLayoutWithBackButton(
        padding: AppSizes.md,
        title:
            const Text('Rewards', style: TextStyle(color: AppColors.primary)),
        centerTitle: true,
        body: AppLayoutWithRefresher(
            onRefresh: rewardController.onRefresh,
            children: [
              const RewardTopCard(),
              const Gap(AppSizes.spaceBtwItems),
              const RewardInstructionCardList(),
              const Gap(AppSizes.spaceBtwSections),
              AppButtons.largeFlatFilledButton(
                backgroundColor: AppColors.secondary,
                  onPressed: (){
                  Get.toNamed('/point-redemption');
                  },
                  buttonText: 'REDEEM POINTS')
            ]));
  }
}


