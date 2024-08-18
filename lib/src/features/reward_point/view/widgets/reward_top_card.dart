import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
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
      return rewardController.hittingApi.value
          ? ShimmerHelper().buildBasicShimmer(height: 200)
          : AppCardContainer(
              width: AppHelperFunctions.screenWidth(),
              hasBorder: true,
              borderColor: AppColors.lightGrey,
              applyRadius: false,
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                                    hasBorder: rewardController
                                            .rewardResponse
                                            .value
                                            .memberships![index]
                                            .isUnlocked !=
                                        1,
                                    backgroundColor: rewardController
                                                .rewardResponse
                                                .value
                                                .memberships![index]
                                                .isUnlocked ==
                                            1
                                        ? AppColors.secondary
                                        : AppColors.white,
                                    child: Icon(
                                      rewardController
                                                  .rewardResponse
                                                  .value
                                                  .memberships![index]
                                                  .isUnlocked ==
                                              1
                                          ? Icons.star
                                          : Icons.lock,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: rewardController.rewardResponse.value.memberships!
                        .map((membership) {
                      return Text("${membership.minRewardPoint}");
                    }).toList(),
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  LinearPercentIndicator(
                    lineHeight: AppSizes.sm,
                    percent: rewardController.percentage.value,
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.lightGrey,
                    progressColor: AppColors.secondary,
                    barRadius: const Radius.circular(AppSizes.borderRadiusMd),
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  RichText(
                    text: TextSpan(
                        text:
                            'Get ${rewardController.rewardResponse.value.nextMemberships!.needPoint}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                              text:
                                  ' more points to become a ${rewardController.rewardResponse.value.nextMemberships!.title} member',
                              style: Theme.of(context).textTheme.labelLarge)
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
                      Text(
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
                    ],
                  ),
                ],
              ),
            );
    });
  }
}
