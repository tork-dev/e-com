import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/containers/horizontal_scroll_product_card.dart';
import 'package:kirei/src/common/widgets/slider/view/app_slider.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
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
import 'package:kirei/src/utils/logging/logger.dart';
import '../../../utils/helpers/routing_helper.dart';
import 'widgets/home_appbar_title.dart';
import 'widgets/home_shop_by_concern.dart';
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
           Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: Obx(() {
                return AppSectionTitleText(
                  sectionTitle: 'Flash sales',
                  flashTime: controller.homeProductResponse.value.featuredProducts?[0].flashSaleEndDate,
                  haveTxtButton: false,
                  showCountDown: true,
                );
              }
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: AppHorizontalScrollProductCard(
                sectionName:
                    controller.homeProductResponse.value.featuredProducts,
              ),
            );
          }),
          const Gap(AppSizes.spaceBtwSections),

          // AppCardContainer(
          //   backgroundColor: AppColors.contentInversePrimary,
          //   margin: EdgeInsets.symmetric(horizontal: AppSizes.md),
          //   borderRadius: AppSizes.cardRadiusMd,
          //     child: Column(
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.all(AppSizes.md),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text("${controller.homeProductResponse.value.homepageSettings?.recommendation?.title}", style: Theme.of(context).textTheme.headlineSmall,),
          //               Gap(AppSizes.xs),
          //               HtmlWidget(
          //                 controller.homeProductResponse.value.homepageSettings?.recommendation?.description ?? '',
          //               ),
          //               Gap(AppSizes.defaultSpace),
          //
          //               AppCardContainer(
          //                   onTap: () {
          //                     Log.d(controller.homeProductResponse.value.homepageSettings!.recommendation!.route!);
          //                     RoutingHelper.urlRouting(controller.homeProductResponse.value.homepageSettings!.recommendation!.route!);
          //                         },
          //                   backgroundColor: AppColors.secondary,
          //                   borderRadius: AppSizes.buttonRadius,
          //                   applyRadius: true,
          //                   padding: const EdgeInsets.only(
          //                       left: AppSizes.defaultSpace,
          //                       right: AppSizes.defaultSpace,
          //                       top: AppSizes.spaceBtwItems,
          //                       bottom: AppSizes.spaceBtwItems),
          //                   child: Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: [
          //                       Text(
          //                         controller.homeProductResponse.value.homepageSettings?.recommendation?.btnName ?? '',
          //                         style:
          //                         const TextStyle(color: AppColors.white),
          //                       ),
          //                     ],
          //                   )),
          //               Gap(AppSizes.spaceBtwSections),
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           width: double.infinity  ,
          //           child: Stack(
          //             clipBehavior: Clip.hardEdge,
          //             children: [
          //               AppBannerImage(
          //                 width: double.infinity  ,
          //                 fit: BoxFit.cover,
          //                   imgUrl: AppImages.skinCareFlowerBg),
          //               Positioned(
          //                 right: 27,
          //                 bottom: 0,
          //                 child: AppBannerImage(
          //                   height: 300,
          //                   isNetworkImage: true,
          //                     imgUrl: controller.homeProductResponse.value.homepageSettings?.recommendation?.banner),
          //               )
          //             ],
          //           ),
          //         )
          //       ],
          //     )
          // ),

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: AppSectionTitleText(
              sectionTitle: 'Best Selling Products',
              haveTxtButton: false,
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: AppHorizontalScrollProductCard(
                sectionName:
                    controller.homeProductResponse.value.bestsellingProducts,
              ),
            );
          }),

          const Gap(AppSizes.spaceBtwSections),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: AppSectionTitleText(
              sectionTitle: 'Recommended For You',
              haveTxtButton: false,
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: AppHorizontalScrollProductCard(
                sectionName:
                    controller.recommendedProductsForYouResponse.value.data,
              ),
            );
          }),
          const HomeSurpriseSection(),

          // const Gap(AppSizes.spaceBtwSections),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          //   child: AppSectionTitleText(
          //     sectionTitle: 'Hot Deals',
          //     haveTxtButton: false,
          //   ),
          // ),
          // Obx(() {
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          //     child: AppHorizontalScrollProductCard(
          //         sectionName:
          //         controller.homeProductResponse.value.featuredProducts),
          //   );
          // }),
          const Gap(AppSizes.spaceBtwSections),
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
                sectionName: controller.homeProductResponse.value.newProducts,
              ),
            );
          }),
          Gap(AppSizes.spaceBtwSections),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: AppSectionTitleText(
              sectionTitle: 'International Brands',
              haveTxtButton: false,
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: AppHorizontalScrollProductCard(
                sectionName:
                    controller.homeProductResponse.value.internationalBrands,
              ),
            );
          }),
          const Gap(AppSizes.spaceBtwSections),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          //   child: AppSectionTitleText(
          //     sectionTitle: 'Trending Products',
          //     haveTxtButton: false,
          //   ),
          // ),
          // Obx(() {
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          //     child: AppHorizontalScrollProductCard(
          //       sectionName: controller.trendingProductsResponse.value.data,
          //     ),
          //   );
          // }),
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
