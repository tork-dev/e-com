import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/widgets/buttons/bottom_button.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/search_bar/app_bar_search.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';
import 'package:torganic/src/features/details/view/widgets/details_description_part.dart';
import 'package:torganic/src/features/details/view/widgets/details_product_name_part.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import '../../../common/styles/skeleton_style.dart';
import '../../../utils/constants/sizes.dart';
import 'widgets/details_picture_part.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.productSlug});

  final int productSlug;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailsPageController(productSlug: productSlug));
    return AppLayoutWithBackButton(
        padding: 0,
        backgroundColor: AppColors.primary,
        title: const AppBarSearch(),
        leadingIconColor: AppColors.white,
        action: const [
          Icon(
            Icons.search,
            color: AppColors.white,
          ),
          Gap(AppSizes.sm),
          Icon(
            Icons.home_outlined,
            color: AppColors.white,
          ),
          Gap(AppSizes.sm),
          Icon(Icons.shopping_bag_outlined, color: AppColors.white),
          Gap(AppSizes.sm),
        ],
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AppLayoutWithRefresher(
                  onRefresh: controller.onRefresh,
                  children:  const [
                    AppDetailsPicturePart(),
                    Gap(AppSizes.spaceBtwItems),
                    AppDetailsProductNamePart(),
                    Gap(AppSizes.spaceBtwItems),
                    AppDetailsDescriptionPart()
                  ]),
            ),
            const Positioned(
              bottom: 0,
              child: AppBottomButton(),
            )
          ],
        ));
  }
}
