import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/containers/horizontal_scroll_product_card.dart';
import 'package:kirei/src/common/widgets/slider/view/app_slider.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/home/views/widgets/home_featured_category.dart';
import 'package:kirei/src/common/widgets/search_bar/search_widget.dart';
import 'package:kirei/src/features/home/views/widgets/home_search_decoration.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'widgets/home_appbar_title.dart';


class HomeThree extends StatelessWidget {
  const HomeThree({super.key});

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final GetShopDataController getShopDataController =
        Get.put(GetShopDataController());
    final ConvexBottomNavController convexBottomNavController =
        ConvexBottomNavController.instance;
    //final isDark = AppHelperFunctions.isDarkMode(context);
    return AppLayoutWithDrawer(
        globalKey: controller.homeKey,
        title: const AppHomeAppBarTitle(),
        leadingIconColor: AppColors.darkerGrey,
        backgroundColor: AppColors.white,
        body: AppLayoutWithRefresher(
            onRefresh: controller.onRefresh,
            children: [
              const Gap(AppSizes.spaceBtwItems),
              AppSearchWidget(
                  builder: (context, controller, focusNode) =>
                      HomeSearchDecoration(
                          categoryController: getShopDataController,
                          bottomController: convexBottomNavController,
                          controller: controller,
                          focusNode: focusNode)),
              const Gap(AppSizes.spaceBtwItems),
              const CustomSlider(),
              const Gap(AppSizes.spaceBtwItems),
              const AppFeatureCategories(),
              const Gap(AppSizes.spaceBtwItems),
              const AppSectionTitleText(
                sectionTitle: 'Best Selling Products',
                haveTxtButton: false,
              ),
              Obx(() {
                return AppHorizontalScrollProductCard(
                    sectionName: controller
                        .homeProductResponse.value.bestsellingProducts);
              }),
              const Gap(AppSizes.spaceBtwSections),
              const AppSectionTitleText(
                sectionTitle: 'Popular Search Products',
                haveTxtButton: false,
              ),
              Obx(() {
                return AppHorizontalScrollProductCard(
                    sectionName: controller
                        .recommendedProductsResponse.value.data);
              }),
              const Gap(AppSizes.spaceBtwSections),
              const AppSectionTitleText(
                sectionTitle: 'Trending Products',
                haveTxtButton: false,
              ),
              Obx(() {
                return AppHorizontalScrollProductCard(
                    sectionName: controller
                        .trendingProductsResponse.value.data);
              }),
              const Gap(AppSizes.spaceBtwSections),
              const AppSectionTitleText(
                sectionTitle: 'Hot Deals',
                haveTxtButton: false,
              ),
              Obx(() {
                return AppHorizontalScrollProductCard(
                    sectionName:
                        controller.homeProductResponse.value.featuredProducts);
              }),
              const Gap(AppSizes.spaceBtwSections),
              const AppSectionTitleText(
                sectionTitle: 'New Arrivals',
                haveTxtButton: false,
              ),
              Obx(() {
                return AppHorizontalScrollProductCard(
                    sectionName:
                        controller.homeProductResponse.value.newProducts);
              }),
              const Gap(70),
            ]));
  }
}
