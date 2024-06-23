import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';

class CommunityController extends GetxController{
  static CommunityController get instance => Get.find();
  final GlobalKey<ScaffoldState> communityKey = GlobalKey<ScaffoldState>();

  TextEditingController communityFieldController = TextEditingController();



  ConvexBottomNavController bottomController  = Get.put(ConvexBottomNavController());
  HomeController homeController  = Get.put(HomeController());
  final shopController = Get.put(ShopController());


  @override
  void onInit() {
    super.onInit();
    homeController.callApis.value = false;
   // shopController.callApis.value = false;

  }

  Future<void> onRefresh()async{
    print('refresh');
  }


}