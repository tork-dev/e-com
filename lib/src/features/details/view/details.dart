import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/buttons/bottom_button.dart';
import 'package:kirei/src/common/widgets/search_bar/app_bar_search.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/features/details/view/widgets/details_categories_part.dart';
import 'package:kirei/src/features/details/view/widgets/details_description_part.dart';
import 'package:kirei/src/features/details/view/widgets/details_full_description.dart';
import 'package:kirei/src/features/details/view/widgets/details_product_name_part.dart';
import 'package:kirei/src/features/details/view/widgets/recom_and_related_product.dart';
import 'package:kirei/src/features/details/view/widgets/review_and_question.dart';
import 'package:kirei/src/features/questions/view/question_screen.dart';
import 'package:kirei/src/features/review/view/review_screen.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'widgets/details_picture_part.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // String id = Get.parameters['id'] ?? '';
     final controller = Get.put(DetailsPageController());
    final categoryController = Get.put(GetShopDataController());
    final bottomController = Get.put(ConvexBottomNavController());
    return AppLayoutWithBackButton(
        padding: 0,
        backgroundColor: AppColors.primary,
        bottomNav: const AppBottomButton(),
        title: Obx(() {
          return AppBarSearch(
            focusOn: categoryController.searchOn.value,
            onSubmit: (txt) {
              categoryController.search.value = txt;
              categoryController.isFromSearch.value = true;
              categoryController.getShopData();
              Get.back();
              bottomController.jumpToTab(1);
            },
          );
        }),
        leadingIconColor: AppColors.white,
        action: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.home_outlined,
              color: AppColors.white,
            ),
          ),
          const Gap(AppSizes.sm),
          InkWell(
              onTap: () {
                Get.back();
                bottomController.jumpToTab(2);
              },
              child: const Icon(Icons.shopping_bag_outlined,
                  color: AppColors.white)),
          const Gap(AppSizes.sm),
        ],
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AppLayoutWithRefresher(
              onRefresh: controller.onRefresh,
              children: [
                const AppDetailsPicturePart(),
                const Gap(AppSizes.spaceBtwItems),
                const AppDetailsProductNamePart(),
                const Gap(AppSizes.spaceBtwItems),
                const AppDetailsDescriptionPart(),
                AppDividersStyle.fullFlatAppDivider,
                const Gap(AppSizes.spaceBtwItems),
                const AppDetailsCategoriesPart(),
                const AppDetailsFullDescription(),
                AppDividersStyle.fullFlatAppDivider,
                ReviewAndQuestion(
                  onTap: () {
                    Get.to(() => ReviewScreen(productId: controller.productDetails.value.detailedProducts!.id!));
                  },
                  title: 'Review',
                ),
                AppDividersStyle.fullFlatAppDivider,
                ReviewAndQuestion(
                  onTap: () {
                    Get.to(() => QuestionScreen(productId: controller.productDetails.value.detailedProducts!.id!));
                  },
                  title: 'questions about this products',
                ),
                AppDividersStyle.fullFlatAppDivider,
                const Gap(AppSizes.spaceBtwItems),
                const Gap(AppSizes.spaceBtwItems),
                const AppRecommendedAndRelatedProducts()
              ]),
        ));
  }
}
