import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_details_description_part.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_product_card.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_shorts_player.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
import '../../../common/styles/app_dividers.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controller/kirei_tube_details_controller.dart';

class KireiTubeShortsDetailsScreen extends StatelessWidget {
  const KireiTubeShortsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KireiTubeDetailsController());
    return AppLayoutWithBackButton(
        centerTitle: true,
        title: const Text(
          'Kirei tube',
          style: TextStyle(color: AppColors.secondary),
        ),
        padding: AppSizes.md,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: [
            const KireiTubeShortsPlayer(),
            const Gap(AppSizes.md),
            const KireiTubeDetailsDescription(),
            AppDividersStyle.fullFlatAppDivider,
            const Gap(AppSizes.md),
            const KireiTubeProductCard(),
            const Gap(AppSizes.md),
            const Gap(AppSizes.defaultSpace),
          ],
        ));
  }
}

