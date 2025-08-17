import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controller/reward_controller.dart';


class RewardTopCard extends StatelessWidget {
  const RewardTopCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RewardController rewardController = RewardController.instance;
    return Obx(() {
      if (rewardController.hittingApi.value) {
        return ShimmerHelper().buildBasicShimmer(height: 200);
      } else {
        return AppCardContainer(
          width: AppHelperFunctions.screenWidth(),
          hasBorder: true,
          borderColor: AppColors.lightGrey,
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/reward-levels');
                    },
                    child: Text(
                      'Membership',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        shadows: [
                          const Shadow(
                              color: Colors.black, offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationThickness: 3,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                  const Gap(AppSizes.xs),
                  SizedBox(
                    height: 20,
                    child: AppListViewLayout(
                      physics: const NeverScrollableScrollPhysics(),
                      isScrollVertically: false,
                      itemCount: rewardController
                          .rewardResponse.value.memberships!.length,
                      applyPadding: true,
                      builderFunction: (context, index) => SizedBox(
                        child: Row(
                          children: [
                            AppCardContainer(
                                height: 16,
                                width: 16,
                                hasBorder: rewardController.rewardResponse.value
                                        .memberships![index].isUnlocked !=
                                    1,
                                backgroundColor: rewardController
                                            .rewardResponse
                                            .value
                                            .memberships![index]
                                            .isUnlocked ==
                                        1
                                    ? AppColors.secondary
                                    : AppColors.white,
                                child: rewardController.rewardResponse.value
                                            .memberships![index].isUnlocked ==
                                        1
                                    ? AppBannerImage(
                                        height: 10,
                                        width: 10,
                                        isNetworkImage: true,
                                        imgUrl: rewardController.rewardResponse
                                            .value.memberships![index].icon)
                                    : Icon(
                                        Icons.lock,
                                        size: 10,
                                        color: rewardController
                                                    .rewardResponse
                                                    .value
                                                    .memberships![index]
                                                    .isUnlocked ==
                                                1
                                            ? AppColors.white
                                            : AppColors.secondary,
                                      )),
                            const Gap(4),
                            Text(
                              rewardController.rewardResponse.value
                                  .memberships![index].title!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(AppSizes.spaceBtwDefaultItems),
              Row(
                children: [
                  AppCardContainer(
                      hasBorder: true,
                      borderWidth: 1,
                      borderRadius: 4,
                      borderColor: AppColors.addToCartButton,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      backgroundColor: const Color(0xffF7F7F7),
                      child: Text(
                          "${rewardController.rewardResponse.value.memberships?[0].minRewardPoint}")),
                  Expanded(
                      flex: (rewardController.rewardResponse.value
                              .memberships![1].minRewardPoint! -
                          rewardController.rewardResponse.value.memberships![0]
                              .minRewardPoint!),
                      child: const SizedBox()),
                  AppCardContainer(
                      hasBorder: true,
                      borderWidth: 1,
                      borderRadius: 4,
                      borderColor: AppColors.addToCartButton,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      backgroundColor: const Color(0xffF7F6ED),
                      child: Text(
                          "${rewardController.rewardResponse.value.memberships?[1].minRewardPoint}")),
                  Expanded(
                      flex: (rewardController.rewardResponse.value
                              .memberships![2].minRewardPoint! -
                          rewardController.rewardResponse.value.memberships![1]
                              .minRewardPoint!),
                      child: const SizedBox()),
                  AppCardContainer(
                      hasBorder: true,
                      borderWidth: 1,
                      borderRadius: 4,
                      borderColor: AppColors.addToCartButton,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      backgroundColor: const Color(0xffF7F2ED),
                      child: Text(
                          "${rewardController.rewardResponse.value.memberships?[2].minRewardPoint}")),
                ],
              ),
              const Gap(AppSizes.spaceBtwDefaultItems),
              LinearPercentIndicator(
                lineHeight: AppSizes.sm,
                percent: rewardController.percentage.value > 0
                    ? rewardController.percentage.value
                    : 0,
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.lightGrey,
                progressColor: AppColors.secondary,
                barRadius: const Radius.circular(AppSizes.borderRadiusMd),
              ),
              const Gap(AppSizes.spaceBtwDefaultItems),
              RichText(
                text: TextSpan(
                    text: rewardController.rewardResponse.value.balance == 0
                        ? "Buy "
                        : rewardController.rewardResponse.value.nextMemberships!
                                    .needPoint! >
                                0
                            ? 'Get ${rewardController.rewardResponse.value.nextMemberships!.needPoint}'
                            : "Congratulation !",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                          text: rewardController.rewardResponse.value.balance ==
                                  0
                              ? "any Product from us to become a "
                              : rewardController.rewardResponse.value
                                          .nextMemberships!.needPoint! >
                                      0
                                  ? ' more points to become a ${rewardController.rewardResponse.value.nextMemberships!.title} member within '
                                      .toLowerCase()
                                  : " you're already our ${rewardController.rewardResponse.value.nextMemberships!.title} member "
                                      .toLowerCase(),
                          style: Theme.of(context).textTheme.labelLarge),
                      TextSpan(
                          text:
                              rewardController.rewardResponse.value.balance == 0
                                  ? "KIP Member!"
                                  : rewardController.rewardResponse.value
                                              .nextMemberships!.needPoint! >
                                          0
                                      ? rewardController.rewardResponse.value
                                              .nextMemberships?.lastDate ??
                                          ''
                                      : '')
                    ]),
              ),
              const Gap(AppSizes.spaceBtwItems),
              AppDividersStyle.fullFlatAppDivider,
              const Gap(AppSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Balance',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(AppSizes.spaceBtwSmallItem),
                      Text(
                          '${rewardController.rewardResponse.value.balance} Points',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/point-history');
                    },
                    child: Text(
                      'Points History',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        shadows: [
                          const Shadow(
                              color: Colors.black, offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}
