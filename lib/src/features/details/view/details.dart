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
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/logging/logger.dart';
import 'widgets/details_picture_part.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    DetailsPageController controller = Get.put(DetailsPageController());
    GetShopDataController categoryController = Get.put(GetShopDataController());
    ConvexBottomNavController bottomController = Get.put(ConvexBottomNavController());

    final slug = Get.parameters['slug'];
    if (slug != null) {
      if (controller.productSlugList[controller.productSlugIndex.value] != slug) {
        controller.productSlugList.add(slug);
        controller.productSlugIndex = controller.productSlugIndex++;
        controller.onRefresh();
        Log.d('calling from ui class');
        Log.d(controller.productSlugList.toString());
      }
    } else {
      Log.e('Slug parameter is null. Route might be incorrect.');
      // Optionally show an error or redirect to a fallback screen
      // Get.offAllNamed('/shop'); // fallback route if you want
    }
    return AppLayoutWithBackButton(
      canPop: false,
        padding: 0,
        showBackButton: false,
        showCustomLeading: true,
        customLeadingIcon: Icons.arrow_back_ios_new_outlined,
        leadingOnPress: () {
        Get.back();
          if (controller.productSlugList.length > 1) {
            Log.d('Backing to prev product');
            controller.productSlugList.removeAt(controller.productSlugIndex.value);
            controller.productSlugIndex.value--; // Correctly decrement index
            Log.d(controller.productSlugList.toString());
            controller.onRefresh();
          }
          // else {
          //   if (controller.prevRoute.value != '') {
          //     Get.back(); // Pop to previous screen
          //     print(controller.prevRoute);
          //   }
          //   else {
          //     Get.offAllNamed(controller.prevRoute.value); // Fallback to home
          //   }
          // }
        },
        backgroundColor: AppColors.primary,
        bottomNav: const AppBottomButton(),
        title: Obx(() {
          Log.d('print product id ${Get.parameters['slug']}');
          return AppBarSearch(
            focusOn: categoryController.searchOn.value,
            onSubmit: (String txt) {
              categoryController.search.value = txt;
              categoryController.isFromSearch.value = true;
              categoryController.getShopData();
              Get.back();
              bottomController.jumpToTab(1);
              EventLogger().logSearchEvent(txt);
              return null;
            },
            prevRoute: '/shop',
          );
        }),
        leadingIconColor: AppColors.white,
        action: [
          InkWell(
            onTap: () {
              Get.offAllNamed('/home');
            },
            child: const Icon(
              Icons.home_outlined,
              color: AppColors.white,
            ),
          ),
          const Gap(AppSizes.sm),
          InkWell(
              onTap: () {
               Get.offAllNamed('/cart');
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
                const Gap(AppSizes.spaceBtwDefaultItems),
                const AppDetailsProductNamePart(),
                const Gap(AppSizes.spaceBtwDefaultItems),
                const AppDetailsDescriptionPart(),
                AppDividersStyle.fullFlatAppDivider,
                const Gap(AppSizes.spaceBtwDefaultItems),
                const AppDetailsCategoriesPart(),
                Obx( () {
                    return AppDetailsFullDescription(
                      descriptionTitle: 'Description',
                      description:
                          "${controller.productDetails.value.detailedProducts?.description}",
                    );
                  }
                ),
                AppDividersStyle.fullFlatAppDivider,
                Obx( () {
                    return AppDetailsFullDescription(
                      descriptionTitle: 'guide',
                      description:
                          "${controller.productDetails.value.detailedProducts?.guide}",
                    );
                  }
                ),
                AppDividersStyle.fullFlatAppDivider,
                ReviewAndQuestion(
                  onTap: () {
                    Get.to(() => ReviewScreen(
                        productId: controller
                            .productDetails.value.detailedProducts!.slug!));
                  },
                  title: 'Review',
                ),
                AppDividersStyle.fullFlatAppDivider,
                ReviewAndQuestion(
                  onTap: () {
                    Get.to(() => QuestionScreen(
                        productId: controller
                            .productDetails.value.detailedProducts!.id!));
                  },
                  title: 'questions about this products',
                ),
                AppDividersStyle.fullFlatAppDivider,
                const Gap(AppSizes.lg),
                const AppRecommendedAndRelatedProducts(),
                const Gap(AppSizes.lg),
              ]),
        ));
  }
}
