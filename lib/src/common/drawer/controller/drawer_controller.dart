import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/repositories/repositories.dart';
import '../model/all_category_model.dart';

class AppDrawerController extends GetxController {
  static AppDrawerController get instance => Get.find();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxInt activeEndDrawerIndex = 0.obs;

  Future<void> setActiveEndDrawerIndex(int index) async {
    activeEndDrawerIndex.value = index;
    update();
  }

  RxList<AllCategory> allNewCategories = <AllCategory>[].obs;
  RxBool mainCategoryExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNewCategories();
  }

  void fetchAllNewCategories() async {
    allNewCategories.value = await DrawerRepositories().getAllNewCategories();
  }

  // Widget openEndDrawer() {
  //   refresh();
  //   return activeEndDrawerIndex.value == 0 ? AppEndDrawer() : AppEndDrawerTwo();
  // }
}
