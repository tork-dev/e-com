import 'dart:io';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badge;
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/cart/view/cart.dart';
import 'package:kirei/src/features/home/views/home_three.dart';
import 'package:kirei/src/features/personalization/view/profile.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/shop/view/shop.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../utils/constants/colors.dart';
import '../../utils/logging/logger.dart';

class HelloConvexAppBar extends StatelessWidget {
  final int pageIndex;

  const HelloConvexAppBar({super.key, this.pageIndex = 0});

  static final List<Widget> children = [
    const HomeThree(),
    const ShopScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    ConvexBottomNavController controller =
        Get.put(ConvexBottomNavController(pageIndexInit: pageIndex));
    // controller.pageIndex.value = pageIndex;
    return Obx(() {
      return PopScope(
          canPop: false,
          onPopInvokedWithResult: (pop, result) {
            if (pop) {
              return;
            }
            if (controller.pageIndex.value == 0) {
              AppHelperFunctions.showAlert(
                  message: 'Do you want to close the app?',
                  leftButtonName: 'Yes',
                  rightButtonName: 'No',
                  onRightPress: () {
                    Get.back();
                  },
                  onLeftPress: () {
                    Get.back();
                    Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                  },
                  rightButtonTextColor: AppColors.secondary,
                  rightButtonColor: Colors.transparent);
            } else if (controller.pageIndex.value == 1 &&
                controller.categoryController.categoryRouteList.length > 1) {
              Log.d('back press in category');
              controller.categoryController.allProducts.clear();

              controller.categoryController.getValuesFromUrl(Uri.parse(
                  controller.categoryController.categoryRouteList[(
                      controller.categoryController.categoryRouteList.length -
                          1) - 1]));

              Log.d(controller.categoryController.categoryRouteList[(
                  controller.categoryController.categoryRouteList.length -
                      1) - 1]);
              controller.categoryController.getShopData();
              controller.categoryController.categoryRouteList.removeAt(
                  controller.categoryController.categoryRouteList.length - 1);
            } else {
              Log.d(controller.categoryController.categoryRouteList.length.toString());
              GetShopDataController().resetAll();
              controller.jumpToTab(0);
            }
          },
          child: Scaffold(
            extendBody: true,
            body: children[controller.pageIndex.value],
            bottomNavigationBar: ConvexAppBar(
              controller: controller.tabController,
              style: TabStyle.react,
              backgroundColor: AppColors.primary,
              activeColor: AppColors.light,
              color: AppColors.white,
              items: [
                const TabItem(
                  icon: Icons.home_outlined,
                  title: 'Home',
                ),
                const TabItem(icon: Icons.storefront_outlined, title: 'Shop'),
                TabItem(
                  icon: badge.Badge(
                    badgeContent: Obx(() {
                      return Text(
                        controller.cartController.cartCount.value.toString(),
                        style: const TextStyle(color: AppColors.white),
                      );
                    }),
                    badgeStyle: const badge.BadgeStyle(
                      badgeColor: AppColors.black,
                      padding: EdgeInsets.all(6),
                    ),
                    child: const Icon(Icons.shopping_bag_outlined,
                        color: AppColors.white),
                  ),
                  title: 'Cart',
                ),
                const TabItem(
                  icon: Icons.account_circle_rounded,
                  title: 'Profile',
                ),
              ],
              initialActiveIndex: controller.pageIndex.value,
              onTap: (index) {
                if (index == 3) {
                  if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) !=
                      true) {
                    Get.offAllNamed('/login/account');
                    return;
                  }
                }
                controller.jumpToTab(index);
              },
            ),
          ));
    });
  }
}
