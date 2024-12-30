import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/notification/controller/notification_details_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/logging/logger.dart';

import '../../../utils/helpers/helper_functions.dart';

class NotificationDetails extends StatelessWidget {
  final int notificationId;

  const NotificationDetails({super.key, required this.notificationId});

  @override
  Widget build(BuildContext context) {
    final detailsController =
        Get.put(NotificationDetailsController(notificationId: notificationId));
    return AppLayoutWithBackButton(
        title: const Text('Notification Details'),
        body: Obx(() {
          Log.i(detailsController.hittingApi.value.toString());
          return detailsController.hittingApi.value
              ? ShimmerHelper().buildListShimmer(itemCount: 10, itemHeight: 70.00)
              : ListView(
                  children: [
                    const Gap(AppSizes.md),
                    Text(
                      detailsController
                              .userNotification.value.data!.data![0].title ??
                          '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(AppSizes.xs),
                    Text(
                      detailsController.userNotification.value.data!.data![0]
                              .description ??
                          '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(AppSizes.md),
                    Text(
                      AppHelperFunctions.formatTimestampWithAgo(
                          detailsController
                              .userNotification.value.data!.data![0].updatedAt),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                );
        }));
  }
}
