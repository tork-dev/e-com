import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class KireiTubeProductCard extends StatelessWidget {
  const KireiTubeProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final kireiTubeDetailsController = KireiTubeDetailsController.instance;
    return Obx(() {
      return AppListViewLayout(
          itemCount: kireiTubeDetailsController.hittingApi.value
              ? 5
              : kireiTubeDetailsController
                  .kireiTubeDetailsResponse.value.data!.products!.length,
          builderFunction: (context, index) {
            return kireiTubeDetailsController.hittingApi.value
                ? ShimmerHelper().buildBasicShimmer(height: 100)
                : AppCardContainer(
                    padding: const EdgeInsets.all(AppSizes.md), child: Text('test'));
          });
    });
  }
}
