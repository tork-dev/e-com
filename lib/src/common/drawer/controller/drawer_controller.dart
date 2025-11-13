import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/repositories/repositories.dart';
import 'package:kirei/src/common/drawer/view/end_drawer.dart';
import 'package:kirei/src/common/drawer/view/end_drawer_two.dart';
import '../model/all_category_model.dart';

class AppDrawerController extends GetxController{

  static AppDrawerController get instance => Get.find();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxInt activeEndDrawerIndex = 0.obs;

  Future<void> setActiveEndDrawerIndex(int index) async{
    activeEndDrawerIndex.value = index;
  }





  RxList<AllCategory> allNewCategories = <AllCategory>[].obs;
  RxBool mainCategoryExpanded = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
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