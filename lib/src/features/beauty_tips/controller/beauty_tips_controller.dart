import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';

import '../../bottom_navigation/convex_controller.dart';
import '../../home/controller/home_controller.dart';

class BeautyTipsController extends GetxController{
  static BeautyTipsController get instance => Get.find();

  final GlobalKey<ScaffoldState> beautyKey = GlobalKey<ScaffoldState>();


  ConvexBottomNavController bottomController  = Get.put(ConvexBottomNavController());
  HomeController homeController  = Get.put(HomeController());
  //ShopController shopController = Get.put(ShopController());


  @override
  void onInit() {
    super.onInit();
    homeController.callApis.value = false;
    //shopController.callApis.value = false;

  }
}