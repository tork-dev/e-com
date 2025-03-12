import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_video_player.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../utils/logging/logger.dart';
import 'kirei_tube_shorts_screen.dart';
import 'widgets/kirei_tube_details_description_part.dart';
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
          style: TextStyle(color: AppColors.secondary),
        ),
        padding: AppSizes.md,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const KireiDetailsVideoPlayer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppCardContainer(
                        onTap: () {
                          if(controller.kireiTubeDetailsResponse.value.data!.prevVideo != null) {
                            controller.videoSlug.value =
                                controller.kireiTubeDetailsResponse.value.data!
                                    .prevVideo!.slug!;
                            controller.onRefresh();
                            if(controller.kireiTubeDetailsResponse.value.data!.prevVideo!.orientation == "portrait"){
                              Get.to(()=> const KireiTubeShortsDetailsScreen());
                            }
                          }else{
                            AppHelperFunctions.showToast("No Previous video found");
                          }
                        },
                        padding: const EdgeInsets.all(AppSizes.sm),
                        isCircle: true,
                        applyRadius: false,
                        backgroundColor: Colors.grey.withAlpha((0.5 * 255).toInt()),
                        margin: const EdgeInsets.only(left: AppSizes.sm),
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                    AppCardContainer(
                        onTap: () {
                          if(controller.kireiTubeDetailsResponse.value.data!.nextVideo != null) {

                            controller.videoSlug.value =
                            controller.kireiTubeDetailsResponse.value.data!
                                .nextVideo!.slug!;
                            controller.onRefresh();

                            if(controller.kireiTubeDetailsResponse.value.data!.nextVideo!.orientation == "portrait"){
                              Get.to(()=> const KireiTubeShortsDetailsScreen());
                            }
                          }else{
                            Log.d(controller.kireiTubeDetailsResponse.value.data!.nextVideo.toString());
                            AppHelperFunctions.showToast("No Next video found");
                          }
                        },
                        padding: const EdgeInsets.all(AppSizes.sm),
                        isCircle: true,
                        applyRadius: false,
                        backgroundColor: Colors.grey.withAlpha((0.5 * 255).toInt()),
                        margin: const EdgeInsets.only(right: AppSizes.sm),
                        child: const Icon(Icons.arrow_forward_ios)),
                  ],
                )
              ],
            ),
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
