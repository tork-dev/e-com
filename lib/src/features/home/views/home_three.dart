import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:torganic/src/common/layouts/gridview_layout/gridview_layout.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/containers/grid_scroll_card.dart';
import 'package:torganic/src/common/widgets/containers/horizontal_scroll_product_card.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import 'package:torganic/src/common/widgets/search_bar/search_bar.dart';
import 'package:torganic/src/common/widgets/slider/view/app_slider.dart';
import 'package:torganic/src/common/widgets/texts/section_title_text.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/home/views/widgets/home_featured_category.dart';
import 'package:torganic/src/features/home/views/widgets/home_hot_deals_product.dart';
import 'package:torganic/src/features/home/views/widgets/home_new_arrivals_product.dart';
import 'package:torganic/src/features/home/views/widgets/home_search_bar.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/image_strings.dart';
import 'widgets/home_appbar_title.dart';
import 'widgets/home_bestselling_product.dart';
import '../../../utils/helpers/helper_functions.dart';

class HomeThree extends StatelessWidget {
  const HomeThree({super.key});

  Future<void> _onRefresh() async {
    debugPrint('_onRefresh');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    //final isDark = AppHelperFunctions.isDarkMode(context);
    return AppLayoutWithDrawer(
        globalKey: controller.homeKey,
        title: const AppHomeAppBarTitle(),
        leadingIconColor: AppColors.darkerGrey,
        backgroundColor: AppColors.white,
        body: AppLayoutWithRefresher(
            onRefresh: controller.getProductData,
            children: [
              const Gap(AppSizes.spaceBtwItems),
              const AppHomeSearchBox(),
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
