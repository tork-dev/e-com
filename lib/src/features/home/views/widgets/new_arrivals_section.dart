import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart' show Obx, Rx;

import '../../../../common/widgets/containers/horizontal_scroll_product_card.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/home_products_model.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({
    super.key,
    required this.homeProductResponse,
  });

  final Rx<HomeProductResponse> homeProductResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: AppSectionTitleText(
            sectionTitle: 'New Arrivals',
            haveTxtButton: false,
          ),
        ),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: AppHorizontalScrollProductCard(
              sectionName: homeProductResponse.value.newProducts,
            ),
          );
        }),
        Gap(AppSizes.spaceBtwSections),
      ],
    );
  }
}
