import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/slider/view/app_slider.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/home/views/widgets/home_featured_category.dart';
import 'package:kirei/src/common/widgets/search_bar/search_widget.dart';
import 'package:kirei/src/features/home/views/widgets/home_new_sections.dart';
import 'package:kirei/src/features/home/views/widgets/home_review_section.dart';
import 'package:kirei/src/features/home/views/widgets/home_search_decoration.dart';
import 'package:kirei/src/features/home/views/widgets/home_trending_section.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'widgets/best_sellling_product_section.dart';
import 'widgets/flash_sale_section.dart';
import 'widgets/home_appbar_title.dart';
import 'widgets/home_shop_by_concern.dart';
import 'widgets/internatinal_brands_section.dart';
import 'widgets/new_arrivals_section.dart';
import 'widgets/recommended_section.dart';
import 'widgets/surprise_section.dart';

class HomeThree extends StatelessWidget {
  const HomeThree({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    GetShopDataController getShopDataController = Get.put(
      GetShopDataController(),
    );
    ConvexBottomNavController convexBottomNavController =
        ConvexBottomNavController.instance;
    return AppLayoutWithDrawer(
      backToHome: true,
      inHome: true,
      globalKey: controller.homeKey,
      title: const AppHomeAppBarTitle(),
      leadingIconColor: AppColors.darkerGrey,
      backgroundColor: AppColors.white,
      padding: 0,
      body: AppLayoutWithRefresher(
        onRefresh: controller.onRefresh,
        children: [
          const Gap(AppSizes.spaceBtwItems),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: AppSearchWidget(
              builder:
                  (
                    BuildContext context,
                    TextEditingController controller,
                    FocusNode focusNode,
                  ) => HomeSearchDecoration(
                    categoryController: getShopDataController,
                    bottomController: convexBottomNavController,
                    controller: controller,
                    focusNode: focusNode,
                  ),
              prevRoute: '/home',
            ),
          ),
          const Gap(AppSizes.spaceBtwItems),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: CustomSlider(),
          ),
          const Gap(AppSizes.spaceBtwSections),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: AppFeatureCategories(),
          ),
          Obx(() {
            return Visibility(
              visible:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.features
                      ?.skinConcern ??
                  false,
              child: const HomeShopByConcern(),
            );
          }),
          const Gap(AppSizes.spaceBtwSections),
          FlashSaleSection(homeProductResponse: controller.homeProductResponse,),
          Obx(() {
            return HomeImageTitleAndButtonSection(
              bgUrl: AppImages.skinCareFlowerBg,
              sectionName:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.recommendation,
              showTheSection:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.features
                      ?.recommendation ??
                  false,
            );
          }),
          const Gap(AppSizes.spaceBtwSections),
          BestSellingProductSection(homeProductResponse: controller.homeProductResponse),
          RecommendedSection(recommendedProductsResponse: controller.recommendedProductsForYouResponse),
          const HomeSurpriseSection(),
          const Gap(AppSizes.spaceBtwSections),
          NewArrivalsSection(homeProductResponse: controller.homeProductResponse),
          Obx(() {
            return HomeImageTitleAndButtonSection(
              showBg: false,
              fit: BoxFit.cover,
              sectionName:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.groupShopping,
              showTheSection:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.features
                      ?.groupShopping ??
                  false,
            );
          }),

          const Gap(AppSizes.spaceBtwSections),
          InternationalBrandsSection(homeProductResponse: controller.homeProductResponse),
          HomeTrendingSection(),
          Gap(AppSizes.spaceBtwSections),
          Obx(() {
            return Visibility(
              visible:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.features
                      ?.reviews ??
                  false,
              child: const HomeReviewSection(),
            );
          }),
          Gap(AppSizes.spaceBtwSections),
          Obx(() {
            return HomeImageTitleAndButtonSection(
              bgUrl: AppImages.kireiTubeBg,
              sectionName:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.kireitube,
              showTheSection:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.features
                      ?.kireitube ??
                  false,
            );
          }),
          const Gap(100),
        ],
      ),
    );
  }
}









