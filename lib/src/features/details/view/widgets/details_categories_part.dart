import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/logging/logger.dart';
import 'details_tag_with_border.dart';
import 'details_tag_with_underline.dart';

class AppDetailsCategoriesPart extends StatelessWidget {
  const AppDetailsCategoriesPart({super.key});

  @override
  Widget build(BuildContext context) {
    DetailsPageController controller = DetailsPageController.instance;
    return Obx(() {
      return Column(
        children: [
          controller.productDetails.value.detailedProducts == null
              ? Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),child: ShimmerHelper().buildBasicShimmer(height: 50))
              : Visibility(
                  visible: controller.productDetails.value.detailedProducts!
                      .skinTypes!.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppDetailsTagBorderWidget(
                          onTap: () {
                          },
                          title: 'Skin Types: ',
                          types: controller.productDetails.value
                              .detailedProducts!.skinTypes!,
                        ),
                      ),
                      const Gap(AppSizes.spaceBtwDefaultItems),
                      AppDividersStyle.fullFlatAppDivider,
                      const Gap(AppSizes.spaceBtwDefaultItems),
                    ],
                  ),
                ),
          controller.productDetails.value.detailedProducts == null
              ? Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),child: ShimmerHelper().buildBasicShimmer(height: 50))
              : Visibility(
                  visible: controller.productDetails.value.detailedProducts!
                      .keyIngredients!.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppDetailsTagUnderlineWidget(
                          onTap: () {
                            Log.d(controller.productDetails.value.detailedProducts!.keyIngredients!.toString());
                          },
                          title: 'Key Ingredients: ',
                          types: controller.productDetails.value
                              .detailedProducts!.keyIngredients!,
                        ),
                      ),
                      const Gap(AppSizes.spaceBtwDefaultItems),
                      AppDividersStyle.fullFlatAppDivider,
                      const Gap(AppSizes.spaceBtwDefaultItems),
                    ],
                  ),
                ),
          controller.productDetails.value.detailedProducts == null
              ? Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),child: ShimmerHelper().buildBasicShimmer(height: 50))
              : Visibility(
            visible: controller.productDetails.value.detailedProducts!
                .goodFor!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppDetailsTagBorderWidget(
                    onTap: () {},
                    title: 'Good For: ',
                    types: controller.productDetails.value
                        .detailedProducts!.goodFor!,
                  ),
                ),
                const Gap(AppSizes.spaceBtwDefaultItems),
                AppDividersStyle.fullFlatAppDivider,
                const Gap(AppSizes.spaceBtwDefaultItems),
              ],
            ),
          ),
          controller.productDetails.value.detailedProducts == null
              ? Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),child: ShimmerHelper().buildBasicShimmer(height: 50))
              : Visibility(
            visible: controller.productDetails.value.detailedProducts!
                .productCategories!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppDetailsTagUnderlineWidget(
                    onTap: () {},
                    title: 'Categories: ',
                    haveColor: true,
                    haveUnderLine: false,
                    types: controller.productDetails.value
                        .detailedProducts!.productCategories!,
                  ),
                ),
                const Gap(AppSizes.spaceBtwDefaultItems),
                AppDividersStyle.fullFlatAppDivider,
                const Gap(AppSizes.spaceBtwDefaultItems),
              ],
            ),
          ),
          controller.productDetails.value.detailedProducts == null
              ? Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),child: ShimmerHelper().buildBasicShimmer(height: 50))
              : Visibility(
            visible: controller.productDetails.value.detailedProducts!
                .productTags!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppDetailsTagUnderlineWidget(
                    onTap: () {},
                    title: 'Tags: ',
                    types: controller.productDetails.value
                        .detailedProducts!.productTags!,
                  ),
                ),
                const Gap(AppSizes.spaceBtwDefaultItems),
                AppDividersStyle.fullFlatAppDivider
              ],
            ),
          ),
        ],
      );
    });
  }
}
