import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/features/community/controller/community_controller.dart';
import 'package:torganic/src/features/community/view/widget/community_header.dart';
import 'package:torganic/src/utils/constants/colors.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommunityController());
    return AppLayoutWithDrawer(
        globalKey: controller.communityKey,
        title: const Text('Kirei Community', style: TextStyle(color: Colors.blueGrey),),
        backgroundColor: AppColors.white,
        leadingIconColor: AppColors.darkGrey,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: [
            CommunityHeader()
          ],
        ));
  }
}

