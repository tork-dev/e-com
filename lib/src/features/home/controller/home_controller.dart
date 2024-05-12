import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/all_category_model.dart';
import '../model/home_products_model.dart';
import '../model/home_sliders_model.dart';
import '../repositories/home_repositories.dart';


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
  }



  // Future<HomeSlidersResponse> getSlidersData() async{
  //   return homeSliders.value = await HomeRepositories.getHomeSliders();
  // }


}