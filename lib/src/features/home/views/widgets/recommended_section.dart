import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/containers/horizontal_scroll_product_card.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../details/model/products_model.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({
    super.key,
    required this.recommendedProductsResponse,
  });

  final Rx<DetailsProductsResponse> recommendedProductsResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSectionTitleText(
          sectionTitle: 'Recommended For You',
          haveTxtButton: false,
        ),
        Obx(() {
          return AppHorizontalScrollProductCard(
            sectionName: recommendedProductsResponse.value.data,
          );
        }),
      ],
    );
  }
}
