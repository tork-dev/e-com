import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';

import '../../../utils/logging/logger.dart';

class ShopController extends GetxController {
  static ShopController get instance => Get.find();
  GetShopDataController getShopDataController = Get.put(
    GetShopDataController(),
  );

  /// Key
  final GlobalKey<ScaffoldState> shopKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    getShopDataController.categoryRouteList.clear();
    // if(getShopDataController.isFromSearch.value == false) {
    // }
    //   onRefresh();
    getShopDataController.getSkinTypesData();
    getShopDataController.addItems();
    super.onInit();
  }

  Future onRefresh() async {
    getShopDataController.allProducts.clear();
    getShopDataController.getShopData();
    getShopDataController.getSkinTypesData();
    Log.d('refresh2');
  }

  final List<String> sortOption = [
    "Default",
    "Best Selling",
    "Rating",
    "Newest",
    "Hot Deal",
    "Price: Low to High",
    "Price: High to Low",
  ];

  final List<int> perPageOption = [9, 12, 24, 36];
}
