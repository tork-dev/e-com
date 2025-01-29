import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/groups_create_now.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/groups_popular_now.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'widgets/group_shopping_header_part.dart';

class GroupShoppingScreen extends StatelessWidget {
  const GroupShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupShoppingController());
    return AppLayoutWithBackButton(
        padding: 0,
        title: const Text(
          'Group Shopping',
          style: TextStyle(color: AppColors.secondary),
        ),
        centerTitle: true,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          scrollController: controller.scrollController,
          children: [
            const GroupShoppingHeaderPart(),
            const Gap(AppSizes.spaceBtwSections),
            Obx(() {
              return Visibility(
                  visible: controller.hittingGroupApi.value ||
                      controller.groupShoppingGroup.value.popular!.isNotEmpty,
                  child: const GroupShoppingPopularNowGroups());
            }),
            Obx(() {
              return Visibility(
                  visible: controller.hittingGroupApi.value ||
                      controller.groupShoppingGroup.value.justCreated!.isNotEmpty,
                  child: const GroupShoppingCreateNowGroups());
            }),
            const Gap(AppSizes.md)
          ],
        ));
  }
}
