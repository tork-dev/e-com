import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/community/controller/community_controller.dart';
import 'package:kirei/src/features/community/view/widget/community_header.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import 'widget/community_post_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommunityController());
    return AppLayoutWithDrawer(
      globalKey: controller.communityKey,
      title: const Text('Kirei Community',
          style: TextStyle(color: Colors.blueGrey)),
      backgroundColor: AppColors.white,
      leadingIconColor: AppColors.darkGrey,
      bodyBackgroundColor: Colors.grey[100],
      isFromOtherPage: true,
      body: Padding(
        padding: const EdgeInsets.only(
            left: AppSizes.xs, right: AppSizes.xs, top: AppSizes.xs),
        child: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children:  const [
            CommunityHeader(),
            Gap(AppSizes.sm),
            CommunityPostContainer()
          ],
        ),
      ),
    );
  }
}


