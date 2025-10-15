import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/home/bindings/home_bindings.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';

import '../../utils/local_storage/local_storage_keys.dart';
import '../../utils/local_storage/storage_utility.dart';
import '../../utils/logging/logger.dart';

class ConvexBottomNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ConvexBottomNavController get instance => Get.find();

  final int pageIndexInit;

  ConvexBottomNavController({this.pageIndexInit = 0});

  final cartController = Get.put(CartController());
  final categoryController = Get.put(GetShopDataController());

  //final logInPageController = Get.put(LogInPageController());

  RxInt pageIndex = 0.obs;

  late TabController tabController;

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    pageIndex.value = pageIndexInit;
    jumpToTab(pageIndexInit);
  }



  // void jumpToTab(int index) {
  //   pageIndex.value = index;
  //   tabController.animateTo(index);
  //   categoryController.categoryRouteList.clear();
  //
  //   if(pageIndex.value == 0){
  //     HomeBinding();
  //   }
  //   if (pageIndex.value == 2) {
  //     cartController.onRefresh();
  //   }
  //   if (pageIndex.value != 1) {
  //     categoryController.resetAll();
  //     return;
  //   }
  //   if (categoryController.isFromSearch.value == false &&
  //       categoryController.isFromCategory.value == false &&
  //       pageIndex.value == 1) {
  //     categoryController.allProducts.clear();
  //     categoryController.getShopData().then((value) {
  //       categoryController.categoryRouteList
  //           .add('/shop?${categoryController.queryStringValue.value}');
  //       Log.d(categoryController.categoryRouteList.toString());
  //     });
  //     return;
  //   }
  // }

  void jumpToTab(int index) {
    // Update tab index and nav bar
    pageIndex.value = index;

    // Animate to tab (if using a TabController)
    if (tabController.indexIsChanging) {
      tabController.animateTo(index);
    }

    // Clear category routes
    categoryController.categoryRouteList.clear();

    // Handle tab-specific logic
    switch (index) {
      case 0:
      // Home tab
        HomeBinding(); // rebind home if needed
        break;

      case 1:
      // Shop tab
        if (!categoryController.isFromSearch.value &&
            !categoryController.isFromCategory.value) {
          categoryController.allProducts.clear();
          categoryController.getShopData().then((_) {
            categoryController.categoryRouteList.add(
              '/shop?${categoryController.queryStringValue.value}',
            );
            Log.d(categoryController.categoryRouteList.toString());
          });
        }
        break;

      case 2:
      // Cart tab
        cartController.onRefresh();
        break;

      case 3:
      // Profile tab (requires login)
        if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != true) {
          Get.offAllNamed('/login/account');
          return;
        }
        break;
    }

    // Reset category when not in Shop tab
    if (index != 1) {
      categoryController.resetAll();
    }
  }


// void changePage(int index) {
//   pageIndex.value = index;
//   if (pageIndex.value == 2) {
//      cartController.onRefresh();
//   }
//   // if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null &&
//   //     pageIndex.value == 3) {
//   //   Get.offAll(() => const LogIn());
//   //   return;
//   // }
//   if(pageIndex.value != 1){
//     categoryController.resetAll();
//     return;
//   }
//   if(categoryController.isFromSearch.value == false && pageIndex.value ==1 ){
//     categoryController.getShopData();
//     return;
//   }
// }
}
