import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/features/reward_point/view/widgets/reward_instruction_card.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class RewardInstructionCardList extends StatelessWidget {
  const RewardInstructionCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RewardInstructionCard(
          imgUrl: 'assets/images/icons/earn_reward.png',
          title: 'How to earn points',
          subTitle: 'There are many variations of passages of Lorem Ipsum.',
        ),
        Gap(AppSizes.spaceBtwItems),
        RewardInstructionCard(
          imgUrl: 'assets/images/icons/redeem_eward.png',
          title: 'How to redeem points',
          subTitle: 'There are many variations of passages of Lorem Ipsum.',
        )
      ],
    );
  }
}

