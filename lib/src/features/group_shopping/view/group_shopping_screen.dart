import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/groups_create_now.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/groups_popular_now.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../../common/widgets/texts/section_title_text.dart';
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
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: const [
            GroupShoppingHeaderPart(),
            Gap(AppSizes.spaceBtwSections),
             GroupShoppingPopularNowGroups(),
             GroupShoppingCreateNowGroups(),
            Gap(AppSizes.md)
          ],
        ));
  }
}
