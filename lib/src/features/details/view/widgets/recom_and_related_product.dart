import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../common/widgets/containers/horizontal_scroll_product_card.dart';
import '../../../../common/widgets/texts/section_title_text.dart';

class AppRecommendedAndRelatedProducts extends StatelessWidget {
  const AppRecommendedAndRelatedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DetailsPageController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        children: [
          const AppSectionTitleText(
            sectionTitle: 'RECOMMENDED FOR YOU',
            haveTxtButton: false,
          ),
          Obx(() {
            return AppHorizontalScrollProductCard(
                sectionName: controller.recommendedProductsResponse.value.data);
          }),
          const Gap(AppSizes.spaceBtwItems),
          const AppSectionTitleText(
            sectionTitle: 'RELATED PRODUCTS',
            haveTxtButton: false,
          ),
          Obx(() {
            return AppHorizontalScrollProductCard(
                sectionName: controller.relatedProductsResponse.value.data);
          }),
        ]),
    );
  }
}

