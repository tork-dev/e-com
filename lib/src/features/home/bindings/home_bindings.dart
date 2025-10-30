import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shop/controller/get_shop_data_controller.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint("✅ HomeBinding initializing...");
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<GetShopDataController>(() => GetShopDataController());
  }
}