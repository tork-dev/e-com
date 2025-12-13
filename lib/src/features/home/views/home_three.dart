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
import 'package:kirei/src/features/home/views/widgets/home_page_service_show.dart';
import 'package:kirei/src/features/home/views/widgets/home_review_section.dart';
import 'package:kirei/src/features/home/views/widgets/home_search_decoration.dart';
import 'package:kirei/src/features/home/views/widgets/home_trending_section.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/helpers/routing_helper.dart';
import '../../web_view/web_view.dart';
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
    GetShopDataController getShopDataController =
        GetShopDataController.instance;
    ConvexBottomNavController convexBottomNavController =
        ConvexBottomNavController.instance;
    return AppLayoutWithDrawer(
      backToHome: true,
      inHome: true,
      globalKey: controller.homeKey,
      title: AppHomeAppBarTitle(
        globalKey: controller.homeKey,
      ),
      leadingIconColor: AppColors.darkerGrey,
      backgroundColor: AppColors.white,
      hasEndDrawer: true,
      action: const [SizedBox()],
      padding: AppSizes.md,
      body: AppLayoutWithRefresher(
        onRefresh: controller.onRefresh,
        children: [
          const Gap(AppSizes.spaceBtwItems),
          AppSearchWidget(
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
          const Gap(AppSizes.spaceBtwItems),
          CustomSlider(),
          const Gap(AppSizes.spaceBtwSections),
          AppFeatureCategories(),
          Obx(() {
            return Visibility(
              visible: controller.showSkinConcern,
              child: const HomeShopByConcern(),
            );
          }),
          const Gap(AppSizes.spaceBtwSections),
          FlashSaleSection(homeProductResponse: controller.homeProductResponse),
          Obx(() {
            return SkinCareCardAiCard(
              onPress: () {
                Get.to(
                  () => WebViewScreen(
                    bodyPadding: 0,
                    url:
                        controller
                            .homeProductResponse
                            .value
                            .homepageSettings
                            ?.recommendation
                            ?.route ??
                        "${AppLocalStorage().readData(LocalStorageKeys.appUrl)}/chat",
                    title: 'Chat',
                  ),
                );
              },
              isVisible: controller.showRecommendation,
              title:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.recommendation
                      ?.title,
              subtitle:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.recommendation
                      ?.description,
              buttonText:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.recommendation
                      ?.btnName,
            );
          }),

          BestSellingProductSection(
            homeProductResponse: controller.homeProductResponse,
          ),
          Obx(() {
            return HomeSurpriseSection(
              onPressed: () => controller.submitSurprisePhone(),
              largeButton: true,
              visibleInputField: true,
              networkImage: true,
              controller: controller.surprisePhoneController,
              visibleSection:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.features
                      ?.surprizeGift ??
                  false,
              imageUrl:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.surprizeGift
                      ?.banner ??
                  "",
              title:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.surprizeGift
                      ?.title ??
                  'Surprise Gift',
              description:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.surprizeGift
                      ?.description ??
                  'Get a surprise gift',
              buttonName:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.surprizeGift
                      ?.btnName ??
                  'Submit',
            );
          }),
          const Gap(AppSizes.spaceBtwSections),
          Obx(() {
            return HomeSurpriseSection(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  RoutingHelper.urlRouting(
                    controller
                            .homeProductResponse
                            .value
                            .homepageSettings
                            ?.groupShopping
                            ?.route ??
                        '${AppLocalStorage().readData(LocalStorageKeys.appUrl)}/group-shopping',
                  );
                });
              },
              largeButton: false,
              visibleInputField: false,
              controller: controller.surprisePhoneController,
              backgroundColor: AppColors.whitePink,
              visibleSection:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.features
                      ?.groupShopping ??
                  false,
              imageUrl:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.groupShopping
                      ?.banner ??
                  '',
              title:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.groupShopping
                      ?.title ??
                  'Save More with Group Shopping!',
              description:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.groupShopping
                      ?.description ??
                  'Save More with Group Shopping!',
              buttonName:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.groupShopping
                      ?.btnName ??
                  'Submit',
            );
          }),
          const Gap(AppSizes.spaceBtwSections),
          InternationalBrandsSection(
            homeProductResponse: controller.homeProductResponse,
          ),
          HomeTrendingSection(),
          RecommendedSection(
            recommendedProductsResponse:
                controller.recommendedProductsForYouResponse,
          ),
          Gap(AppSizes.spaceBtwSections),
          Obx(() {
            return Visibility(
              visible: controller.showReviews,
              child: const HomeReviewSection(),
            );
          }),
          const Gap(AppSizes.spaceBtwSections),
          NewArrivalsSection(
            homeProductResponse: controller.homeProductResponse,
          ),

          Obx(() {
            return SkinCareCardAiCard(
              onPress: () {
                RoutingHelper.urlRouting(
                  controller
                          .homeProductResponse
                          .value
                          .homepageSettings
                          ?.kireitube
                          ?.route ??
                      '${AppLocalStorage().readData(LocalStorageKeys.appUrl)}/kirei-tube',
                );
              },
              isVisible: controller.showKireiTube,
              backgroundColor: AppColors.whitePink,
              title:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.kireitube
                      ?.title,
              subtitle:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.kireitube
                      ?.description,
              buttonText:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.kireitube
                      ?.btnName,
              imageUrl:
                  controller
                      .homeProductResponse
                      .value
                      .homepageSettings
                      ?.kireitube
                      ?.banner,
              hasImageSize: true,
            );
          }),
        ],
      ),
    );
  }
}
