import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/common/drawer/controller/drawer_controller.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/wishlist/view/wishlist.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/image_strings.dart';

class AppHomeAppBarTitle extends StatelessWidget {
  const AppHomeAppBarTitle({super.key, required this.globalKey});

  final GlobalKey<ScaffoldState> globalKey;

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.put(AppDrawerController());
    final bottomController = ConvexBottomNavController.instance;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 70, child: Image.asset(AppImages.lightAppLogo)),
          Row(
            children: [
              Obx(() {
                return InkWell(
                  onTap: () {
                    if (AppLocalStorage().readData(
                          LocalStorageKeys.isLoggedIn,
                        ) !=
                        null) {
                      Get.to(() => WishlistScreen());
                    } else {
                      Get.to(() => LogIn());
                    }
                  },
                  child: Badge(
                    backgroundColor: AppColors.primary,
                    label: Text(
                      "${bottomController.wishListController.wishlistCount.value}",
                    ),
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedFavourite,
                      color: AppColors.darkerGrey,
                    ),
                  ),
                );
              }),
              const Gap(AppSizes.spaceBtwItems),
              Obx(() {
                return InkWell(
                  onTap: () {
                    drawerController
                        .setActiveEndDrawerIndex(1)
                        .then(
                          (value) => globalKey.currentState?.openEndDrawer(),
                        );
                  },
                  child: Badge(
                    backgroundColor: AppColors.primary,
                    label: Text(
                      "${bottomController.cartController.cartCount.value}",
                    ),
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedShoppingCart01,
                      color: AppColors.darkerGrey,
                    ),
                  ),
                );
              }),

              const Gap(AppSizes.spaceBtwItems),
              InkWell(
                onTap: () {
                  if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) ==
                      true) {
                    bottomController.jumpToTab(3);
                  } else {
                    Get.offAll(const LogIn());
                  }
                },
                child:
                    AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) ==
                            true
                        ? AppCardContainer(
                          applyRadius: true,
                          padding: const EdgeInsets.all(5),
                          height: 40,
                          width: 40,
                          borderRadius: 100,
                          // backgroundColor: Colors.black,
                          hasBorder: true,
                          borderWidth: 1,
                          borderColor: AppColors.secondary,
                          child: AppBannerImage(
                            isNetworkImage: true,
                            imgUrl:
                                '${AppLocalStorage().readData(LocalStorageKeys.avatarOriginal)}',
                          ),
                        )
                        : const HugeIcon(
                          icon: HugeIcons.strokeRoundedUser,
                          color: AppColors.darkerGrey,
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
