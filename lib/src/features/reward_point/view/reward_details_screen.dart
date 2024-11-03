import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/reward_point/controller/reward_controller.dart';
import 'package:kirei/src/features/reward_point/controller/reward_details_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import 'widgets/kip_card_widget.dart';

class RewardDetailsPage extends StatelessWidget {
  const RewardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardController = Get.put(RewardDetailsController());
    return AppLayoutWithBackButton(
        title: const Text('Reward details'),
        centerTitle: true,
        padding: 0,
        body: ListView(
          controller: rewardController.scrollController,
          children: [
            AppCardContainer(
                width: AppHelperFunctions.screenWidth(),
                backgroundColor: const Color(0xffF5F5FF),
                applyRadius: false,
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: [
                    Text(
                      'Earn More as You Shop!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: AppColors.primary),
                    ),
                    const Gap(AppSizes.xs),
                    Text(
                      'Introducing Our Exclusive Loyalty Program',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AppColors.secondary),
                    ),
                    const Gap(AppSizes.sm),
                    Text(
                      "We believe in rewarding our customers for their loyalty and engagement. With our brand-new point system, the more you shop and interact, the more benefits you unlock! Here's how you can level up and enjoy fantastic rewards.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: AppColors.secondary),
                    ),
                  ],
                )),
            const Gap(AppSizes.spaceBtwSections),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KipCardWidget(
                    cardColor: Color(0xffF7F7F7),
                    messageSideColor: Color(0xffB9BDBD),
                    kipIcon: AppImages.silverIcon,
                    kipTitle: 'KIP-Silver',
                    kipSubtitle:
                        'Become a KIP-Silver member with just one successful order!',
                    pointQuantity: '1',
                    kipMessage:
                        'Start earning points right away and redeem them on your future purchases',
                  ),
                  const Gap(AppSizes.defaultSpace),
                  const KipCardWidget(
                    cardColor: Color(0xffF7F6ED),
                    messageSideColor: Color(0xffE8AB16),
                    kipIcon: AppImages.goldIcon,
                    kipTitle: 'KIP-Gold',
                    kipSubtitle:
                        'Earn 100 points successfully within the last 6 months to reach KIP-Gold status.',
                    pointQuantity: '1.5',
                    kipMessage:
                        'Exclusive Benefits: Enjoy special discounts on selected products and early access to offers.',
                  ),
                  const Gap(AppSizes.defaultSpace),
                  const KipCardWidget(
                    cardColor: Color(0xffF7F2ED),
                    messageSideColor: Color(0xffE57122),
                    kipIcon: AppImages.platinumIcon,
                    kipTitle: 'KIP-Platinum',
                    kipSubtitle:
                        'Achieve KIP-Platinum by earning 300 points successfully in the last 6 months.',
                    pointQuantity: '2',
                    kipMessage:
                        'Platinum Perks: Unlock exclusive discounts on selected products, special gifts, and first access to promotions and offers.',
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  Text(
                    'Extra Ways to Earn Points',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Gap(AppSizes.sm),
                  Text(
                    'Not only can you earn points by shopping, but we also reward your activities on our site',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Gap(AppSizes.defaultSpace),
                  const Row(
                    children: [
                      Icon(Icons.check_circle_outline_outlined),
                      Gap(AppSizes.sm),
                      Text('Community Posts: Earn 3 points per post.')
                    ],
                  ),
                  const Gap(AppSizes.md),
                  const Row(
                    children: [
                      Icon(Icons.check_circle_outline_outlined),
                      Gap(AppSizes.sm),
                      Text('Product Reviews: Earn 5 points per review.')
                    ],
                  ),
                  const Gap(AppSizes.md),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          color: const Color(0xffCB5E5A),
                        ),
                        const Gap(AppSizes.sm),
                        Expanded(
                          child: Text(
                            'For every 100 BDT spent on product purchases, you’ll continue to earn even more points!',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: AppColors.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSizes.md),
                  const AppBannerImage(
                      applyImageRadius: false,
                      imgUrl: AppImages.rewardLadyImage)
                ],
              ),
            ),
            const Gap(AppSizes.spaceBtwSections),
            AppCardContainer(
                key: rewardController.targetWidgetToScroll,
                backgroundColor: const Color(0xffFFF5F9),
                applyRadius: false,
                width: AppHelperFunctions.screenWidth(),
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: [
                    const AppBannerImage(
                        height: 88, width: 88, imgUrl: AppImages.redeemPoint),
                    const Gap(AppSizes.md),
                    Text(
                      'How to redeem points?',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Gap(AppSizes.sm),
                    Text(
                      'Customers can easily redeem their earned reward points through following our bellow reward points guideline',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(AppSizes.defaultSpace),
                    const Row(
                      children: [
                        Icon(Icons.check_circle_outline_outlined),
                        Gap(AppSizes.sm),
                        Expanded(
                            child: Text(
                                'Customers need to have a minimum 100 points to redeem'))
                      ],
                    ),
                    const Gap(AppSizes.md),
                    const Row(
                      children: [
                        Icon(Icons.check_circle_outline_outlined),
                        Gap(AppSizes.sm),
                        Expanded(
                            child: Text(
                                'After 100 points ,it can be redeemed in the multiple of 50'))
                      ],
                    ),
                  ],
                )),
            const Gap(AppSizes.spaceBtwSections),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: AppCardContainer(
                applyRadius: false,
                width: AppHelperFunctions.screenWidth(),
                backgroundColor: AppColors.addToCartButton,
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: [
                    Text(
                      'Unlock Rewards with Ease',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AppColors.white),
                    ),
                    const Gap(AppSizes.sm),
                    Text(
                      "Whether you're buying your favorite skincare products or engaging with our community, points add up quickly. Join today and start collecting your rewards!",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: AppColors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(AppSizes.defaultSpace),
                    SizedBox(
                      width: 280,
                      child: AppButtons.largeFlatFilledButton(
                          onPressed: () {
                            Get.offAllNamed('/shop');
                          },
                          backgroundColor: AppColors.white,
                          buttonTextColor: AppColors.addToCartButton,
                          buttonText: 'Start shopping'),
                    )
                  ],
                ),
              ),
            ),
            const Gap(AppSizes.appBarHeight)
          ],
        ));
  }
}
