import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/features/notification/controller/notification_details_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class NotificationDetails extends StatelessWidget {
  final int notificationId;
  const NotificationDetails({super.key, required this.notificationId});

  @override
  Widget build(BuildContext context) {
    final detailsController = Get.put(NotificationDetailsController(notificationId: notificationId));
    return AppLayoutWithBackButton(
      title: const Text('Notification Details'),
        body: ListView(
          children: [
            const Gap(AppSizes.md),
            Text('Notification Title', style: Theme.of(context).textTheme.titleLarge,),
            const Gap(AppSizes.xs),
            Text('Notification Description', style: Theme.of(context).textTheme.bodySmall,),
            const Gap(AppSizes.md),
            Text('1hours ago', style: Theme.of(context).textTheme.labelMedium,),
          ],
        ));
  }
}

