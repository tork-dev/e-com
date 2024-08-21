import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/layouts/gridview_layout/gridview_layout.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_list_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class KireiTubeScreen extends StatelessWidget {
  const KireiTubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KireiTubeController());
    return AppLayoutWithBackButton(
        padding: AppSizes.md,
        title: const Text(
          'Kirei tube',
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
                  itemCount: controller.hittingApi.value
                      ? 10
                      : controller.videoList.value.data!.length,
                  builderFunction: (context, index) {
                    return controller.hittingApi.value
                        ? ShimmerHelper().buildBasicShimmer(height: 250)
                        : KireiTubeListCard(index: index);
                  },
                );
              })
            ],
          ),
        ));
  }
}
