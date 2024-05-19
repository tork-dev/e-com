import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badge;
import 'package:torganic/src/features/authentication/views/log_in/view/login.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/cart/view/cart.dart';
import 'package:torganic/src/features/home/views/home_three.dart';
import 'package:torganic/src/features/personalization/view/profile.dart';
import 'package:torganic/src/features/shop/view/shop.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

import '../../utils/constants/colors.dart';

class HelloConvexAppBar extends StatelessWidget {
   const HelloConvexAppBar({super.key});





  static List children = [
    const HomeThree(),
    const ShopScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];


  @override
  Widget build(BuildContext context) {
    final convexBottomNavController = Get.put(ConvexBottomNavController());
    return Scaffold(
      extendBody: true,
      body: Obx(() => children[convexBottomNavController.pageIndex.value]

      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: AppColors.primary,
        activeColor: AppColors.light,
        color: AppColors.white,
        items:  [
          const TabItem(
            icon: Icons.home_outlined,
            title: 'Home',
          ),

          const TabItem(icon: Icons.storefront_outlined, title: 'Shop'),

          TabItem(
            icon: badge.Badge(
                badgeContent: Obx(() {
                    return Text(convexBottomNavController.cartController.cartCount.value,
                      style: const TextStyle(color: AppColors.white),);
                  }
                ),
                badgeStyle: const badge.BadgeStyle(
                  badgeColor: AppColors.black,
                  padding: EdgeInsets.all(6)
                ),
                
                child: const Icon(Icons.shopping_bag_outlined, color: AppColors.white,)),
            title: 'Cart'
    ),
          const TabItem(
              icon: Icons.account_circle_rounded,
              title: 'Profile')
        ],
        initialActiveIndex: convexBottomNavController.pageIndex.value,
        onTap: (int index)=>convexBottomNavController.changePage(index),
      ),
    );
  }
}