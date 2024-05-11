
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/shop/model/shop_data_model.dart';
import 'package:torganic/src/features/shop/repositories/shop_repositories.dart';

class ShopController extends GetxController{
  static ShopController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> shopKey = GlobalKey<ScaffoldState>();

  ///Controllers
  final TextEditingController minimumPriceController = TextEditingController();
  final TextEditingController maximumPriceController = TextEditingController();

  /// Model
  Rx<ShopPageResponse> shopPageProduct = ShopPageResponse().obs;


  @override
  void onInit() {
    getShopData();
    super.onInit();
  }

  Future<ShopPageResponse> getShopData() async {
    return shopPageProduct.value = await ShopRepositories().getFilteredProducts();
  }
}