
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:torganic/src/features/shop/model/shop_data_model.dart';
import 'package:torganic/src/features/shop/model/sub_category_model.dart';
import 'package:torganic/src/features/shop/repositories/shop_repositories.dart';

import '../model/skin_type_model.dart';

class ShopController extends GetxController{
  static ShopController get instance => Get.find();

  GetShopDataController getShopDataController = Get.put(GetShopDataController());

  final bottomController = ConvexBottomNavController.instance;

  /// Key
  final GlobalKey<ScaffoldState> shopKey = GlobalKey<ScaffoldState>();




  @override
  void onInit() {
    onRefresh();
    getShopDataController.addItems();
      //getShopDataController.scrollController.addListener(getShopDataController.scrollListener);
    super.onInit();
  }

  Future onRefresh()async{
    getShopDataController.getShopData();
    getShopDataController.getSkinTypesData();
  }










}