import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/home/model/home_products_model.dart';
import 'package:torganic/src/features/home/repositories/home_repositories.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> homeTwoKey = GlobalKey<ScaffoldState>();

  RxInt carousalCurrentIndex = 0.obs;

  Rx<HomeProductResponse> homeProductResponse = HomeProductResponse().obs;

  @override
  void onInit(){
    //print('this is response: ${homeProductResponse.success}');
    getProductData();
    super.onInit();
  }


  Future<HomeProductResponse> getProductData() async {
   return homeProductResponse.value = await HomeRepositories.getHomeProducts();
  }


}