import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/reward_point/controller/reward_controller.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_instruction_card.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../web_view/web_view.dart';

class RewardInstructionCardList extends StatelessWidget {
  const RewardInstructionCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final String baseUrlWeb = dotenv.env["BASE_URL_WEB"]!;
    final controller = RewardController.instance;
    return  Column(
      children: [
        InkWell(
          onTap: (){
            Get.toNamed('/reward-details');
          },
          child: const RewardInstructionCard(
            imgUrl: 'assets/images/icons/earn_reward.png',
            title: 'How to earn points',
            subTitle: [
              'For every 100 BDT spent on product purchases, you’ll continue to earn even more points!',
              'Product Reviews: Earn 5 points per review.',
              'Community Posts: Earn 3 points per post.'
            ],
          ),
        ),
        const Gap(AppSizes.spaceBtwItems),
        InkWell(
          onTap: (){
            Get.toNamed('/reward-details', arguments: 'redeem');
            },
          child: const RewardInstructionCard(
            imgUrl: 'assets/images/icons/redeem_reward.png',
            title: 'How to redeem points',
            subTitle: [
              'Customers need to have a minimum 100 points to redeem',
              'After 100 points ,it can be redeemed in the multiple of 50'
            ],
          ),
        )
      ],
    );
  }
}

