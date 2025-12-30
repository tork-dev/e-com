import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kirei/src/features/personalization/view/dashboard.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:badges/badges.dart' as badge;
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../utils/caching/caching_utility.dart';
import '../../utils/logging/logger.dart';
import '../cart/view/cart.dart';
import '../home/views/home_three.dart';
import '../shop/controller/get_shop_data_controller.dart';
import '../shop/view/shop.dart';
import 'convex_controller.dart';

class GoogleNavBar extends StatelessWidget {
  const GoogleNavBar({super.key, required this.pageIndex});

  final int pageIndex;

  static const List _widgetOptions = [
    HomeThree(),
    ShopScreen(),
    CartScreen(),
    UserDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    final ConvexBottomNavController controller =
    Get.put(ConvexBottomNavController(pageIndexInit: pageIndex));
    final categoryCtrl = GetShopDataController.instance;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (pop, result) async {
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
                CachingUtility.clearAll();
                Get.back();
                Platform.isAndroid ? SystemNavigator.pop() : exit(0);
              },
              rightButtonTextColor: AppColors.secondary,
              rightButtonColor: Colors.transparent);
        } else if (controller.pageIndex.value == 1 &&
            categoryCtrl.categoryRouteList.length > 1) {

          Log.d('Back press in category');

          // Clear old products
          categoryCtrl.allProducts.clear();
          categoryCtrl.resetAll();

          // Get second last route
          final previousRoute = categoryCtrl.categoryRouteList[
          categoryCtrl.categoryRouteList.length - 2
          ];

          Log.d("Previous route: $previousRoute");

          // Update values & reload API
          categoryCtrl.getValuesFromUrl(previousRoute);
          await categoryCtrl.getShopData();

          // Remove last route
          categoryCtrl.categoryRouteList.removeLast();

          Log.i("Updated route list: ${categoryCtrl.categoryRouteList}");
        } else {
          Log.d(controller.categoryController.categoryRouteList.length.toString());
          GetShopDataController().resetAll();
          controller.jumpToTab(0);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
              () => Center(
            child: _widgetOptions.elementAt(controller.pageIndex.value),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withAlpha(AppHelperFunctions.toAlpha(0.1)),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm,
                vertical: AppSizes.sm,
              ),
              // 👇 wrap GNav in Obx so it rebuilds when pageIndex changes
              child: Obx(
                    () => GNav(
                  tabBorderRadius: AppSizes.sm,
                  curve: Curves.easeInOut,
                  color: Colors.grey[800],
                  gap: AppSizes.sm,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  tabBackgroundColor: AppColors.primary,
                  // tabBackgroundGradient: LinearGradient(
                  //   begin: Alignment.centerLeft,
                  //   end: Alignment.centerRight,
                  //   colors: [
                  //     AppColors.primary,
                  //     AppColors.primary.withAlpha(128),
                  //   ],
                  // ),
                  tabs: [
                    const GButton(
                      icon: CupertinoIcons.home,
                      text: 'Home',
                    ),
                    const GButton(
                      icon: Icons.storefront_outlined,
                      text: 'Shop',
                    ),
                    GButton(
                      icon: CupertinoIcons.bag,
                      leading: badge.Badge(
                        badgeContent: Obx(
                              () => Text(
                            controller.cartController.cartCount.value.toString(),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        badgeStyle: const badge.BadgeStyle(
                          badgeColor: AppColors.black,
                          padding: EdgeInsets.all(6),
                        ),
                        child: Icon(
                          CupertinoIcons.bag,
                          color: controller.pageIndex.value == 2
                              ? AppColors.white
                              : Colors.grey[800],
                        ),
                      ),
                      text: 'Cart',
                    ),
                    const GButton(
                      icon: CupertinoIcons.person,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: controller.pageIndex.value,
                  onTabChange: (index) => controller.jumpToTab(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
