import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/containers/horizontal_scroll_product_card.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/home_products_model.dart';

class BestSellingProductSection extends StatelessWidget {
  const BestSellingProductSection({
    super.key,
    required this.homeProductResponse,
  });

  final Rx<HomeProductResponse> homeProductResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSectionTitleText(
          sectionTitle: 'Best Selling Products',
          haveTxtButton: false,
        ),
        Obx(() {
          return AppHorizontalScrollProductCard(
            sectionName: homeProductResponse.value.bestsellingProducts,
          );
        }),

        const Gap(AppSizes.spaceBtwSections),
      ],
    );
  }
}
