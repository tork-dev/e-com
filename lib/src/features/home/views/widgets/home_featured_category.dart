import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/appoinment/view/appointment_screen.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/beauty_tips/view/beauty_tips.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/community/view/community_screen.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../utils/constants/colors.dart';
import '../../../ai_recommendation/view/skin_care_history/recomedation_screen_one.dart';

class AppFeatureCategories extends StatelessWidget {
  const AppFeatureCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final categoryPassingController = Get.put(GetShopDataController());
    final bottomController = ConvexBottomNavController.instance;

    return Obx(() {
      return SizedBox(
          height:
              homeController.homeFeaturedCategoryResponse.isEmpty ? 80 : 130,
          child: AppListViewLayout(
              isScrollVertically: false,
              itemCount: homeController.homeFeaturedCategoryResponse.isEmpty
                  ? 5
                  : homeController.homeFeaturedCategoryResponse.length,
              builderFunction: (BuildContext context, int index) =>
                  homeController.homeFeaturedCategoryResponse.isEmpty
                      ? ShimmerHelper()
                          .buildBasicShimmer(height: 80, width: 80, radius: AppSizes.borderRadiusMd)
                      : SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              AppBannerImage(
                                onPress: () {
                                  if (homeController
                                          .homeFeaturedCategoryResponse[index]
                                          .slug ==
                                      'AiSuggestion()') {
                                    if (AppLocalStorage().readData(
                                            LocalStorageKeys.isLoggedIn) ==
                                        true) {
                                      Get.offAll(
                                          () => const SkinCareHistoryOne());
                                    } else {
                                      Get.to(() => const LogIn());
                                    }
                                  }
                                  if (homeController
                                          .homeFeaturedCategoryResponse[index]
                                          .slug! ==
                                      'BeautyTips()') {
                                    Get.offAll(() => const BeautyTipsScreen());
                                    return;
                                  }
                                  if (homeController
                                          .homeFeaturedCategoryResponse[index]
                                          .slug! ==
                                      'FeedList()') {
                                    Get.offAll(() => const CommunityScreen());
                                    return;
                                  }
                                  if (homeController
                                          .homeFeaturedCategoryResponse[index]
                                          .slug! ==
                                      'Appointment()') {
                                    Get.offAll(() => const AppointmentScreen());
                                    return;
                                  }
                                  categoryPassingController.updateCategory(
                                      homeController
                                          .homeFeaturedCategoryResponse[index]
                                          .slug!);
                                  // categoryPassingController.getShopData();
                                  // categoryPassingController.getSubCategory();
                                  bottomController.jumpToTab(1);
                                },
                                backgroundColor: AppColors.accent,
                                height: 80,
                                width: 80,
                                imgBoarderRadius: AppSizes.borderRadiusMd,
                                fit: BoxFit.cover,
                                isNetworkImage: homeController
                                        .homeFeaturedCategoryResponse[index]
                                        .icon !=
                                    null,
                                imgUrl: homeController
                                        .homeFeaturedCategoryResponse[index]
                                        .icon ??
                                    AppImages.placeholder,
                              ),
                              const Gap(AppSizes.sm),
                              Text(
                                homeController
                                    .homeFeaturedCategoryResponse[index].name!,
                                style: Theme.of(context).textTheme.labelLarge,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )));
    });
  }
}
