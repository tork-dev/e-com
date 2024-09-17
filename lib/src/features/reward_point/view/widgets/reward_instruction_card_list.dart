import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_instruction_card.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../web_view/web_view.dart';

class RewardInstructionCardList extends StatelessWidget {
  const RewardInstructionCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        InkWell(
          onTap: (){
            Get.to(() => const WebViewScreen(
                title: 'Earn points',
                url: "https://kireibd.com/earn-points?type=app"));
          },
          child: const RewardInstructionCard(
            imgUrl: 'assets/images/icons/earn_reward.png',
            title: 'How to earn points',
            subTitle: 'Welcome to our Reward Points Program! Earn points with every interaction and redeem them for exciting rewards.',
          ),
        ),
        const Gap(AppSizes.spaceBtwItems),
        InkWell(
          onTap: (){
            Get.to(() => const WebViewScreen(
                title: 'Redeem points',
                url: "https://kireibd.com/redeem-points?type=app"));
          },
          child: const RewardInstructionCard(
            imgUrl: 'assets/images/icons/redeem_reward.png',
            title: 'How to redeem points',
            subTitle: 'Welcome to our Redeem Points Program! Redeem points with every interaction and redeem them for exciting rewards.',
          ),
        )
      ],
    );
  }
}

