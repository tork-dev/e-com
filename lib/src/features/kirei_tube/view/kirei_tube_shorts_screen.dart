import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_details_description_part.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_product_card.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_shorts_player.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
import '../../../common/styles/app_dividers.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controller/kirei_tube_details_controller.dart';
import 'kirei_tube_details.dart';

class KireiTubeShortsDetailsScreen extends StatelessWidget {
  const KireiTubeShortsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KireiTubeDetailsController());
    return AppLayoutWithBackButton(
        centerTitle: true,
        title: const Text(
          'Kirei tube',
          style: TextStyle(color: AppColors.black),
        ),
        padding: AppSizes.md,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: [
            AppCardContainer(
              applyRadius: false,
              backgroundColor: AppColors.addToCartButton,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppCardContainer(
                      height: AppHelperFunctions.screenHeight() * 0.6,
                      child: const KireiTubeShortsPlayer()),
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
                              if(controller.kireiTubeDetailsResponse.value.data!.prevVideo!.orientation == "landscape"){
                                Get.to(()=> const KireiTubeDetailsScreen());
                              }else{
                                Get.to(()=> const KireiTubeShortsDetailsScreen());
                              }
                            }else{
                              AppHelperFunctions.showToast("No Previous video found");
                            }
                          },
                          padding: const EdgeInsets.all(AppSizes.sm),
                          isCircle: true,
                          applyRadius: false,
                          backgroundColor: Colors.grey.withOpacity(.5),
                          margin: const EdgeInsets.only(left: AppSizes.sm),
                          child: const Icon(Icons.arrow_back_ios_new_rounded)),
                      AppCardContainer(
                          onTap: () {
                            if(controller.kireiTubeDetailsResponse.value.data!.nextVideo != null) {
                              controller.videoSlug.value =
                              controller.kireiTubeDetailsResponse.value.data!
                                  .nextVideo!.slug!;

                              controller.onRefresh();
                              if(controller.kireiTubeDetailsResponse.value.data!.nextVideo!.orientation == "landscape"){
                                Get.to(()=> const KireiTubeDetailsScreen());
                              }else{
                                Get.to(()=> const KireiTubeShortsDetailsScreen());
                              }
                            }else{
                              AppHelperFunctions.showToast("No Next video found");
                            }
                          },
                          padding: const EdgeInsets.all(AppSizes.sm),
                          backgroundColor: Colors.grey.withOpacity(.5),
                          margin: const EdgeInsets.only(right: AppSizes.sm),
                          isCircle: true,
                          applyRadius: false,
                          child: const Icon(Icons.arrow_forward_ios)),
                    ],
                  )
                ],
              ),
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

