import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/styles/spacing_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/appoinment/view/appointment_screen.dart';
import 'package:kirei/src/features/beauty_tips/view/beauty_tips.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/community/view/community_screen.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/home/repositories/home_repositories.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AppFeatureCategories extends StatelessWidget {
  const AppFeatureCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final categoryPassingController = Get.put(GetShopDataController());
    final bottomController = ConvexBottomNavController.instance;

    return SizedBox(
        height: 100,
        child: Obx(() {
          return AppListViewLayout(
              isScrollVertically: false,
              itemCount: homeController.homeFeaturedCategoryResponse.isEmpty
                  ? 5
                  : homeController.homeFeaturedCategoryResponse.length,
              builderFunction: (BuildContext context, int index) =>
                  homeController.homeFeaturedCategoryResponse.isEmpty
                      ? ShimmerHelper().buildBasicShimmer(
                          height: 60, width: 100, radius: 100)
                      : Column(
                          children: [
                            AppBannerImage(
                              onPress: () {
                                if (homeController
                                        .homeFeaturedCategoryResponse[index]
                                        .slug! ==
                                    'BeautyTips()') {
                                  Get.offAll(()=> const BeautyTipsScreen());
                                  return;
                                }
                                if (homeController
                                        .homeFeaturedCategoryResponse[index]
                                        .slug! ==
                                    'FeedList()') {
                                  Get.offAll(()=> const CommunityScreen());
                                  return;
                                }
                                if (homeController
                                        .homeFeaturedCategoryResponse[index]
                                        .slug! ==
                                    'Appointment()') {
                                  Get.offAll(()=> const AppointmentScreen());
                                  return;
                                }
                                categoryPassingController.updateCategory(
                                    homeController
                                        .homeFeaturedCategoryResponse[index]
                                        .slug!);
                                categoryPassingController.getShopData();
                                categoryPassingController.getSubCategory();
                                bottomController.jumpToTab(1);
                              },
                              height: 60,
                              width: 60,
                              isNetworkImage: true,
                              imgUrl: homeController
                                      .homeFeaturedCategoryResponse[index]
                                      .icon ??
                                  'https://kireibd.com/images/home/categories/New-Arrivals.png',
                            ),
                            const Gap(AppSizes.sm),
                            Text(
                              homeController
                                  .homeFeaturedCategoryResponse[index].name!,
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          ],
                        ));
        }));
  }
}
