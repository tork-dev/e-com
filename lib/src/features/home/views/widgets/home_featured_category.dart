import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/shop/view/hot_deals_screen.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/colors.dart';

class AppFeatureCategories extends StatelessWidget {
  const AppFeatureCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final categoryPassingController = Get.put(GetShopDataController());
    final bottomController = ConvexBottomNavController.instance;

    return Obx(() {
      return Column(
        children: [
          AppSectionTitleText(
            sectionTitle: 'Featured categories',
            haveTxtButton: false,
            showCountDown: false,
          ),
          SizedBox(
            height:
                homeController.homeFeaturedCategoryResponse.isEmpty ? 80 : 130,
            child: AppListViewLayout(
              isScrollVertically: false,
              itemCount:
                  homeController.homeFeaturedCategoryResponse.isEmpty
                      ? 5
                      : homeController.homeFeaturedCategoryResponse.length,
              builderFunction:
                  (BuildContext context, int index) =>
                      homeController.homeFeaturedCategoryResponse.isEmpty
                          ? ShimmerHelper().buildBasicShimmer(
                            height: 80,
                            width: 80,
                            radius: AppSizes.borderRadiusMd,
                          )
                          : SizedBox(
                            width: 92,
                            child: Column(
                              children: [
                                AppBannerImage(
                                  onPress: () {
                                    homeController
                                                .homeFeaturedCategoryResponse[index]
                                                .slug ==
                                            "hot-deals"
                                        ? Get.to(() => HotDealsScreen())
                                        : homeController.homeFeaturedCategoryResponse[index].url!.contains("/shop")?
                                        {
                                          categoryPassingController.resetAll(),
                                          categoryPassingController.getValuesFromUrl(homeController.homeFeaturedCategoryResponse[index].url!),
                                          bottomController.jumpToTab(1)
                                        }
                                        :
                                    WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                              RoutingHelper.urlRouting(
                                                homeController
                                                    .homeFeaturedCategoryResponse[index]
                                                    .url,
                                              );
                                            });
                                  },
                                  backgroundColor: AppColors.lightGrey,
                                  height: 80,
                                  width: 80,
                                  imgBoarderRadius: AppSizes.borderRadiusMd,
                                  fit: BoxFit.cover,
                                  isNetworkImage:
                                      homeController
                                          .homeFeaturedCategoryResponse[index]
                                          .icon !=
                                      null,
                                  imgUrl:
                                      homeController
                                          .homeFeaturedCategoryResponse[index]
                                          .icon ??
                                      AppImages.placeholder,
                                ),
                                const Gap(AppSizes.sm),
                                Text(
                                  homeController
                                      .homeFeaturedCategoryResponse[index]
                                      .name!,
                                  style: Theme.of(context).textTheme.labelLarge,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
            ),
          ),
        ],
      );
    });
  }
}
