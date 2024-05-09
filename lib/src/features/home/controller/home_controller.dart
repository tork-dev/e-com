import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:torganic/src/features/home/model/home_products_model.dart';
import 'package:torganic/src/features/home/repositories/home_repositories.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> homeTwoKey = GlobalKey<ScaffoldState>();

  RxInt carousalCurrentIndex = 0.obs;

  HomeProductResponse homeProductResponse = HomeProductResponse();

  @override
  void onInit(){
    print('this is response: ${homeProductResponse.success}');
    getProductData();
    super.onInit();
  }


  Future<HomeProductResponse> getProductData() async {
   // if(homeProductResponse.value.success)
   return homeProductResponse = await HomeRepositories.getHomeProducts();
  }


}