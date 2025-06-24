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
        return Visibility(
          visible: homeProductResponse.value.homepageSettings?.features?.flashSale ?? false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: AppSectionTitleText(
                    sectionTitle: 'Flash sales',
                    flashTime: homeProductResponse.value.featuredProducts?[0].flashSaleEndDate,
                    haveTxtButton: false,
                    showCountDown: true,
                  )
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                  child: AppHorizontalScrollProductCard(
                    sectionName:
                    homeProductResponse.value.featuredProducts,
                  ),
                ),
              const Gap(AppSizes.spaceBtwSections),
            ],
          ),
        );
      }
    );
  }
}