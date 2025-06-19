import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../shop/controller/get_shop_data_controller.dart';

class HomeShopByConcern extends StatelessWidget {
  const HomeShopByConcern({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final shopController = Get.put(GetShopDataController());
    final bottomController = ConvexBottomNavController.instance;
    double cardWidth = MediaQuery.of(context).size.width / 3.50;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSizes.defaultSpace),
          const AppSectionTitleText(
            sectionTitle: 'Shop By Concern',
            haveTxtButton: false,
          ),

          CarouselSlider(
            options: CarouselOptions(
              height: 210,
              // enlargeCenterPage: true,
              viewportFraction: 1 / 3,
              autoPlay: true,
            ),
            items: List.generate(
              homeController.hittingApi.value
                  ? 5
                  : homeController.homeProductResponse.value.reviews!.length,
              (index) {
                return AppCardContainer(
                  borderRadius: AppSizes.borderRadiusSm,
                  child: Column(
                    children: [
                      AppBannerImage(
                        applyOnlyRadius: true,
                        topRightRadius: AppSizes.borderRadiusMd,
                        topLeftRadius: AppSizes.borderRadiusMd,
                        onPress: () {
                          shopController.resetAll();
                          shopController.goodFor.value =
                              homeController
                                  .homeProductResponse
                                  .value
                                  .skinConcern![index]
                                  .slug ??
                              '';
                          bottomController.jumpToTab(1);
                        },
                        width: cardWidth,
                        height: 160,
                        fit: BoxFit.cover,
                        isNetworkImage:
                            homeController
                                .homeProductResponse
                                .value
                                .skinConcern![index]
                                .banner !=
                            null,
                        imgUrl:
                            homeController
                                .homeProductResponse
                                .value
                                .skinConcern![index]
                                .banner ??
                            'assets/images/demo/Acne.png',
                      ),
                      AppCardContainer(
                        onTap: () {
                          shopController.resetAll();
                          shopController.goodFor.value =
                              homeController
                                  .homeProductResponse
                                  .value
                                  .skinConcern![index]
                                  .slug ??
                              '';
                          bottomController.jumpToTab(1);
                        },
                        applyOnlyRadius: true,
                        bottomLeftRadius: AppSizes.borderRadiusMd,
                        bottomRightRadius: AppSizes.borderRadiusMd,
                        width: cardWidth,
                        backgroundColor: AppColors.lightGrey,
                        applyRadius: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm,
                          vertical: AppSizes.spaceBtwDefaultItems,
                        ),
                        child: Center(
                          child: Text(
                            homeController
                                    .homeProductResponse
                                    .value
                                    .skinConcern![index]
                                    .title ??
                                'Acne',
                            style: Theme.of(context).textTheme.labelLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
