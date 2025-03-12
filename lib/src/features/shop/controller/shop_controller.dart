import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';

import '../../../utils/logging/logger.dart';

class ShopController extends GetxController{
  static ShopController get instance => Get.find();
  GetShopDataController getShopDataController = Get.put(GetShopDataController());

  /// Key
  final GlobalKey<ScaffoldState> shopKey = GlobalKey<ScaffoldState>();




  @override
  void onInit() {
    getShopDataController.categoryRouteList.clear();
    if(getShopDataController.isFromSearch.value == false) {
      onRefresh();
    }
    getShopDataController.addItems();
    super.onInit();
  }

  Future onRefresh()async{
    // getShopDataController.getShopData();
    getShopDataController.getSkinTypesData();

    Log.d('refresh2');
  }










}