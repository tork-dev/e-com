import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/cart/view/cart.dart';
import 'package:torganic/src/features/home/views/home_three.dart';
import 'package:torganic/src/features/shop/view/shop.dart';

import '../../utils/constants/colors.dart';

class HelloConvexAppBar extends StatelessWidget {
   const HelloConvexAppBar({super.key});





  static const List children = [
    HomeThree(),
    ShopScreen(),
    CartScreen(),
    // Cart(has_bottomnav: true),
    // Profile(),
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
        items: const [
          TabItem(
            icon: Icons.home_outlined,
            title: 'Home',
          ),

          TabItem(icon: Icons.storefront_outlined, title: 'Shop'),

          TabItem(
            icon: Icon(Icons.shopping_bag_outlined, color: AppColors.white,),
            title: 'Cart'
    ),
          TabItem(
              icon: Icons.account_circle_rounded,
              title: 'Profile')
        ],
        initialActiveIndex: convexBottomNavController.pageIndex.value,
        onTap: (int index)=>convexBottomNavController.changePage(index),
      ),
    );
  }
}