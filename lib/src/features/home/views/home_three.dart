import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/gridview_layout/gridview_layout.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/containers/grid_scroll_card.dart';
import 'package:torganic/src/common/widgets/containers/horizontal_scroll_card.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import 'package:torganic/src/common/widgets/search_bar/search_bar.dart';
import 'package:torganic/src/common/widgets/slider/view/app_slider.dart';
import 'package:torganic/src/common/widgets/texts/section_title_text.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/home/views/widgets/home_featured_category.dart';
import 'package:torganic/src/features/home/views/widgets/home_search_bar.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/image_strings.dart';
import 'widgets/home_appbar_title.dart';
import 'widgets/home_product_card.dart';
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
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _onRefresh,
              child: CustomScrollView(
                  controller: ScrollController(),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        const Gap(AppSizes.spaceBtwItems),
                        const CustomHomeSearchBox(),
                        const Gap(AppSizes.spaceBtwItems),
                        //AppBannerImage(imgUrl: AppImages.banner2),
                        const CustomSlider(
                          items: [
                            'https://app.kireibd.com/storage/all/Banner-2-8.jpg',
                            'https://app.kireibd.com/storage/all/Banner-1-OPT.jpg',
                            // AppImages.banner3,
                          ],
                        ),
                        const Gap(AppSizes.spaceBtwItems),
                        const HomeFeaturedCategories(),
                        const Gap(AppSizes.spaceBtwSections),
                        const AppSectionTitleText(
                          sectionTitle: 'Best Selling Products',
                          haveTxtButton: false,
                        ),
                        const AppHomeProductCard(),
                        const Gap(AppSizes.spaceBtwSections),
                        const AppSectionTitleText(
                          sectionTitle: 'Popular Searched Products',
                          haveTxtButton: false,
                        ),
                        const AppHomeProductCard(),
                        const Gap(AppSizes.spaceBtwSections),
                        const AppSectionTitleText(
                          sectionTitle: 'Trending Products',
                          haveTxtButton: false,
                        ),
                        const AppHomeProductCard(),
                        const Gap(AppSizes.spaceBtwSections),
                      ]),
                    ),
                  ]),
            ),
          ],
        ));
  }
}
