import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import '../../utils/local_storage/local_storage_keys.dart';
import '../../utils/local_storage/storage_utility.dart';
import '../authentication/views/log_in/view/login.dart';

class ConvexBottomNavController extends GetxController with GetSingleTickerProviderStateMixin {
  static ConvexBottomNavController get instance => Get.find();

  final cartController = Get.put(CartController());

  RxInt pageIndex = 0.obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  void jumpToTab(int index) {
    tabController.animateTo(index);
    pageIndex.value = index;
  }

  void changePage(int index) {
    pageIndex.value = index;
    if (pageIndex.value == 2) {
      cartController.onRefresh();
    }
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null && pageIndex.value == 3) {
      Get.offAll(() => const LogIn());
    }
  }
}
