import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';

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
    // if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true){
    //   await logInPageController.getUserDataByToken();
    //   AuthHelper().saveUserDataByToken(logInPageController.userDataByToken);
    // }
  }

  void jumpToTab(int index) {
    pageIndex.value = index;
    tabController.animateTo(index);
    categoryController.categoryRouteList.clear();

    if (pageIndex.value == 2) {
      cartController.onRefresh();
    }
    if (pageIndex.value != 1) {
      categoryController.resetAll();
      return;
    }
    if (categoryController.isFromSearch.value == false &&
        categoryController.isFromCategory.value == false &&
        pageIndex.value == 1) {
      categoryController.allProducts.clear();
      categoryController.getShopData().then((value) {
        categoryController.categoryRouteList
            .add('/shop?${categoryController.queryStringValue.value}');
        print(categoryController.categoryRouteList);
      });
      return;
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
