import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';

import '../../../../common/styles/app_dividers.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../utils/constants/sizes.dart';
import 'details_tag_with_border.dart';
import 'details_tag_with_underline.dart';


class AppDetailsCategoriesPart extends StatelessWidget {
  const AppDetailsCategoriesPart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DetailsPageController.instance;
    return Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.productDetails.value.detailedProducts ==
                  null
                  ? ShimmerHelper().buildBasicShimmer(height: 50)
                  : AppDetailsTagBorderWidget(
                onTap: () {},
                title: 'Skin Types: ',
                types: controller.productDetails.value
                    .detailedProducts!.skinTypes!,
              ),

            const Gap(AppSizes.spaceBtwItems),
            AppDividersStyle.fullFlatAppDivider,
            const Gap(AppSizes.spaceBtwItems),
             controller.productDetails.value.detailedProducts ==
                  null
                  ? ShimmerHelper().buildBasicShimmer(height: 50)
                  : AppDetailsTagUnderlineWidget(
                onTap: () {},
                title: 'Key Ingredients: ',
                types: controller.productDetails.value
                    .detailedProducts!.keyIngredients!,
              ),
            const Gap(AppSizes.spaceBtwItems),
            AppDividersStyle.fullFlatAppDivider,
            const Gap(AppSizes.spaceBtwItems),
             controller.productDetails.value.detailedProducts ==
                  null
                  ? ShimmerHelper().buildBasicShimmer(height: 50)
                  : AppDetailsTagBorderWidget(
                onTap: () {},
                title: 'Good For: ',
                types: controller.productDetails.value
                    .detailedProducts!.goodFor!,
             ),
            const Gap(AppSizes.spaceBtwItems),
            AppDividersStyle.fullFlatAppDivider,
            const Gap(AppSizes.spaceBtwItems),

            controller.productDetails.value.detailedProducts == null?
                ShimmerHelper().buildBasicShimmer(height: 50) :
                AppDetailsTagUnderlineWidget(
                    onTap: (){},
                    title: 'Categories: ',
                    haveColor: true,
                    haveUnderLine: false,
                    types: controller.productDetails.value.detailedProducts!.productCategories!),
            const Gap(AppSizes.spaceBtwItems),
            AppDividersStyle.fullFlatAppDivider,
            const Gap(AppSizes.spaceBtwItems),
            controller.productDetails.value.detailedProducts ==
                null
                ? ShimmerHelper().buildBasicShimmer(height: 50)
                : AppDetailsTagUnderlineWidget(
              onTap: () {},
              title: 'Tags: ',
              types: controller.productDetails.value
                  .detailedProducts!.productTags!,
            ),

            const Gap(AppSizes.spaceBtwItems),
            AppDividersStyle.fullFlatAppDivider
          ],
        );
      }
    );
  }
}

