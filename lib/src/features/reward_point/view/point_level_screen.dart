import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/reward_point/controller/point_reward_Level_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class RewardPointLevelScreen extends StatelessWidget {
  const RewardPointLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardPointLevelController());
    return AppLayoutWithBackButton(
        padding: AppSizes.md,
        title: const Text(
          'Levels',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        body: Padding(
          padding: const EdgeInsets.only(top: AppSizes.md),
          child: AppLayoutWithRefresher(
            onRefresh: controller.onRefresh,
            children: [
              Obx(() {
                  return AppListViewLayout(
                      itemCount: !controller.hittingApi.value
                          ? controller.pointLevel.value.data!.length
                          : 5,
                      builderFunction: (context, index) {
                        return controller.hittingApi.value
                            ? ShimmerHelper().buildBasicShimmer(height: 100)
                            : AppCardContainer(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.spaceBtwDefaultItems,
                                    vertical: AppSizes.md),
                                applyRadius: false,
                                backgroundColor: AppColors.lightGrey,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    child: Image.network(
                                        controller.pointLevel.value.data![index].icon ?? ''),
                                  ),
                                  title: RichText(
                                      text: TextSpan(
                                          text: controller
                                              .pointLevel.value.data![index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                          children: [
                                        TextSpan(
                                            text: ' (Level ${index + 1})',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium)
                                      ])),
                                  subtitle: Text(
                                    controller.pointLevel.value.data![index].description ?? 'Minimum ${controller.pointLevel.value.data![index].minRewardPoint} point need to be a ${controller.pointLevel.value.data![index].title} member',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ));
                      });
                }
              )
            ],
          ),
        ));
  }
}
