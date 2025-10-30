import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/containers/horizontal_scroll_product_card.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/home_products_model.dart';

class InternationalBrandsSection extends StatelessWidget {
  const InternationalBrandsSection({
    super.key,
    required this.homeProductResponse,
  });

  final Rx<HomeProductResponse> homeProductResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSectionTitleText(
          sectionTitle: 'International Brands',
          haveTxtButton: false,
        ),
        Obx(() {
          return AppHorizontalScrollProductCard(
            sectionName: homeProductResponse.value.internationalBrands,
          );
        }),
        const Gap(AppSizes.spaceBtwSections),
      ],
    );
  }
}
