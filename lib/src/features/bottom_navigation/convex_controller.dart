import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import 'package:torganic/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/utils/helpers/auth_helper.dart';
import '../../utils/local_storage/local_storage_keys.dart';
import '../../utils/local_storage/storage_utility.dart';
import '../authentication/views/log_in/model/user_by_token_response.dart';
import '../authentication/views/log_in/repository/login_repository.dart';
import '../authentication/views/log_in/view/login.dart';

class ConvexBottomNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ConvexBottomNavController get instance => Get.find();

  final cartController = Get.put(CartController());
  final categoryController = Get.put(GetShopDataController());
  //final logInPageController = Get.put(LogInPageController());


  RxInt pageIndex = 0.obs;

  late TabController tabController;

  @override
  void onInit() async{
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    // if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true){
    //   await logInPageController.getUserDataByToken();
    //   AuthHelper().saveUserDataByToken(logInPageController.userDataByToken);
    // }
  }

  void jumpToTab(int index) {
    tabController.animateTo(index);
    pageIndex.value = index;
    if (pageIndex.value == 2) {
      cartController.onRefresh();
    }
    // final shopController = Get.put(ShopController());
    // if(pageIndex.value != 1){
    //   shopController.resetAll();
    // }
  }

  void changePage(int index) {
    pageIndex.value = index;
    if (pageIndex.value == 2) {
      cartController.onRefresh();
    }
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null &&
        pageIndex.value == 3) {
      Get.to(() => const LogIn());
      return;
    }
    if(pageIndex.value != 1){
      categoryController.resetAll();
      return;
    }
    if(categoryController.isFromSearch.value == false && pageIndex.value ==1 ){
      ShopController shopController = Get.put(ShopController());
      shopController.onRefresh();
      return;
    }
  }

}
