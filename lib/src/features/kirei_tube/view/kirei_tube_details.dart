import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_video_player.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import 'widgets/kirei_tube_product_card.dart';

class KireiTubeDetailsScreen extends StatelessWidget {
  const KireiTubeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KireiTubeDetailsController());
    return AppLayoutWithBackButton(
        centerTitle: true,
        title: const Text(
          'Kirei tube',
          style: TextStyle(color: AppColors.primary),
        ),
        padding: AppSizes.md,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: const [
            KireiDetailsVideoPlayer(),
            Gap(AppSizes.md),
            KireiTubeProductCard()
          ],
        ));
  }
}
