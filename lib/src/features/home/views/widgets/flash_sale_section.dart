import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/containers/horizontal_scroll_product_card.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/home_products_model.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({
    super.key,
    required this.homeProductResponse,
  });

  final Rx<HomeProductResponse> homeProductResponse;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isFlashSaleEnabled =
          homeProductResponse.value.homepageSettings?.features?.flashSale ?? false;

      final featuredProducts = homeProductResponse.value.featuredProducts;

      // Check if the list has at least one item
      final hasValidProduct = featuredProducts != null && featuredProducts.isNotEmpty;

      return Visibility(
        visible: isFlashSaleEnabled && hasValidProduct,
        child: Column(
          children: [
            AppSectionTitleText(
              sectionTitle: 'Hot Deals',
              flashTime: hasValidProduct
                  ? featuredProducts[0].flashSaleEndDate ?? DateTime.now()
                  : DateTime.now(), // fallback
              haveTxtButton: false,
              showCountDown: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: AppHorizontalScrollProductCard(
                sectionName: featuredProducts,
              ),
            ),
            const Gap(AppSizes.spaceBtwSections),
          ],
        ),
      );
    });
  }
}
