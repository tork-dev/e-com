import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/reward_point/controller/point_history_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class RewardPointHistoryScreen extends StatelessWidget {
  const RewardPointHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardPointHistoryController());
    return AppLayoutWithBackButton(
        leadingIconColor: AppColors.darkGrey,
        padding: AppSizes.md,
        title: const Text(
          'Point History',
          style: TextStyle(color: AppColors.secondary),
        ),
        centerTitle: true,
        body:
            AppLayoutWithRefresher(onRefresh: controller.onRefresh, children: [
          Obx(() {
            return !controller.hittingAPi.value &&
                    controller.rewardHistory.value.data!.isEmpty
                ? const Center(
                    child: Text('No history found'),
                  )
                : AppListViewLayout(
                    itemCount: !controller.hittingAPi.value
                        ? controller.rewardHistory.value.data!.length
                        : 10,
                    builderFunction: (context, index) {
                      String formatedDate = '';
                      if (controller.rewardHistory.value.data?[index].date !=
                          null) {
                        formatedDate = DateFormat('d MMM yyyy').format(
                            controller.rewardHistory.value.data![index].date!);
                      }
                      return controller.hittingAPi.value
                          ? ShimmerHelper().buildBasicShimmer(height: 100)
                          : AppCardContainer(
                              padding: const EdgeInsets.all(AppSizes.md),
                              backgroundColor: AppColors.secondaryBackground,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${controller.rewardHistory.value.data![index].details?.source} on $formatedDate",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        controller
                                                .rewardHistory
                                                .value
                                                .data![index]
                                                .totalRewardPointEarned
                                                .toString()
                                                .contains("-")
                                            ? '${controller.rewardHistory.value.data![index].totalRewardPointEarned}'
                                            : '+${controller.rewardHistory.value.data![index].totalRewardPointEarned}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .apply(
                                                color: controller
                                                        .rewardHistory
                                                        .value
                                                        .data![index]
                                                        .totalRewardPointEarned
                                                        .toString()
                                                        .contains("-")
                                                    ? AppColors.error
                                                    : AppColors.success),
                                      ),
                                    ],
                                  ),
                                  const Gap(AppSizes.spaceBtwDefaultItems),
                                  Text(
                                    controller.rewardHistory.value.data![index]
                                                .event ==
                                            "Order"
                                        ? 'Order Id : ${controller.rewardHistory.value.data![index].details?.orderId}'
                                        : controller.rewardHistory.value
                                                    .data![index].event ==
                                                'Review'
                                            ? "Product Name: ${controller.rewardHistory.value.data![index].details?.productName}"
                                            : "Post Title : ${controller.rewardHistory.value.data![index].details?.postTitle}",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ));
                    });
          })
        ]));
  }
}
