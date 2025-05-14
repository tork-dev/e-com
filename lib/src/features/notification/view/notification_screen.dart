import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/notification/controller/notification_controller.dart';
import 'package:kirei/src/features/notification/view/notification_details.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    return AppLayoutWithBackButton(
      title: Text('Notification', style: TextStyle(color: AppColors.white),),
      centerTitle: true,
      leadingIconColor: AppColors.white,
      backgroundColor: AppColors.primary,
      body: AppLayoutWithRefresher(onRefresh: controller.onRefresh, children: [
        const Gap(AppSizes.lg),
        Obx(() {
          return AppListViewLayout(
            itemCount: controller.hittingApi.value
                ? 10
                : controller.notificationList.value.data!.data!.isEmpty
                    ? 1
                    : controller.notificationList.value.data!.data!.length,
            builderFunction: (context, index) => controller.hittingApi.value
                ? ShimmerHelper().buildBasicShimmer(height: 150)
                : controller.notificationList.value.data!.data!.isEmpty
                    ? Center(
                        child: Text(
                          "You have no notifications",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    : AppCardContainer(
                        onTap: () => Get.to(() => NotificationDetails(
                              notificationId: controller.notificationList.value
                                  .data!.data![index].id!,
                            )),
                        padding: const EdgeInsets.only(top: AppSizes.sm),
                        hasBorder: true,
                        borderWidth: 1,
                        borderColor: AppColors.lightGrey,
                        child: ListTile(
                          leading: AppCardContainer(
                            height: 40,
                            width: 40,
                            borderRadius: AppSizes.sm,
                            backgroundColor: AppColors.primary.withAlpha((0.1 * 255).toInt()),
                            child: const Icon(Icons.notifications_none_sharp),
                          ),
                          isThreeLine: true,
                          title: Text(
                            controller.notificationList.value.data!.data![index]
                                    .title ??
                                '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.notificationList.value.data!
                                        .data![index].description ??
                                    '',
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(AppSizes.spaceBtwDefaultItems),
                              Text(
                                  AppHelperFunctions.formatTimestampWithAgo(
                                      controller.notificationList.value.data!
                                          .data![index].createdAt),
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                          trailing: Visibility(
                            visible: controller.notificationList.value.data!
                                    .data![index].seenAt ==
                                null,
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
          );
        })
      ]),
    );
  }
}
