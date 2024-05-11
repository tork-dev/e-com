import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/home/model/home_featured_category_model.dart';
import 'package:torganic/src/features/home/model/home_products_model.dart';
import 'package:torganic/src/features/home/repositories/home_repositories.dart';

import '../model/all_category_model.dart';
import '../model/home_sliders_model.dart';


class HomeController extends GetxController{
  static HomeController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> homeTwoKey = GlobalKey<ScaffoldState>();

  RxInt carousalCurrentIndex = 0.obs;

  /// Model Class Instance
  Rx<HomeProductResponse> homeProductResponse = HomeProductResponse().obs;
  RxList homeFeaturedCategoryResponse = [].obs;
  RxList<AllCategory> allCategories = <AllCategory>[].obs;
  Rx<HomeSlidersResponse> homeSliders = HomeSlidersResponse().obs;

  @override
  void onInit(){
    fetchFeaturedCategories();
    getProductData();
    fetchAllCategories();
    super.onInit();
  }


  Future<HomeProductResponse> getProductData() async {
   return homeProductResponse.value = await HomeRepositories.getHomeProducts();
  }

  void fetchFeaturedCategories() async {
    var categoryResponse =
    await HomeRepositories().getHomeFeaturedCategories();
    homeFeaturedCategoryResponse.addAll(categoryResponse);
  }

  void fetchAllCategories() async {
      allCategories.value = await HomeRepositories().getAllCategories();
      for (var category in allCategories) {
        if (category.children != null) {
          for (var child in category.children!) {
          }
        }
      }
  }

  // Future<HomeSlidersResponse> getSlidersData() async{
  //   return homeSliders.value = await HomeRepositories.getHomeSliders();
  // }


}