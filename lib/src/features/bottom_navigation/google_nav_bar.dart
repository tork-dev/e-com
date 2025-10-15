import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/features/personalization/view/dashboard.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:badges/badges.dart' as badge;
import '../../utils/local_storage/local_storage_keys.dart';
import '../../utils/local_storage/storage_utility.dart';
import '../cart/view/cart.dart';
import '../home/controller/home_controller.dart';
import '../home/views/home_three.dart';
import '../shop/view/shop_new.dart';
import 'convex_controller.dart';

class GoogleNavBar extends StatelessWidget {
  const GoogleNavBar({super.key, required this.pageIndex});

  final int pageIndex;

  static const List _widgetOptions = [
    HomeThree(),
    ShopScreenNew(),
    CartScreen(),
    UserDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    final ConvexBottomNavController controller =
    Get.put(ConvexBottomNavController(pageIndexInit: pageIndex));

    return Scaffold(
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
              color: Colors.black.withOpacity(.1),
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
                tabBorderRadius: 14,
                curve: Curves.easeInOut,
                color: Colors.grey[800],
                gap: AppSizes.sm,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                tabBackgroundGradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withAlpha(128),
                  ],
                ),
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
    );
  }
}
