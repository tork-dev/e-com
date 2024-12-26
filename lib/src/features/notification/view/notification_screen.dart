import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/notification/controller/notification_controller.dart';
import 'package:kirei/src/features/notification/view/notification_details.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    return AppLayoutWithBackButton(
      title: const Text('Notification'),
      centerTitle: true,
      body: AppLayoutWithRefresher(onRefresh: controller.onRefresh, children: [
        const Gap(AppSizes.md),
        AppListViewLayout(
          itemCount: 10,
          builderFunction: (context, index) => AppCardContainer(
            onTap: ()=> Get.to(()=> const NotificationDetails()),
            padding: const EdgeInsets.only(top: AppSizes.sm),
            hasBorder: true,
            borderWidth: 1,
            borderColor: AppColors.lightGrey,
            child: ListTile(
              leading: AppCardContainer(
                height: 40,
                width: 40,
                borderRadius: AppSizes.sm,
                backgroundColor: AppColors.primary.withOpacity(.1),
                child: const Icon(Icons.notifications_none_sharp),
              ),
              isThreeLine: true,
              title: Text(
                'Notification Title',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but als",
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  Text('1h ago',
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              trailing: Container(
                height: 8,
                width: 8,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
