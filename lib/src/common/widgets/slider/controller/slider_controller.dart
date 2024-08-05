
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/home/model/home_sliders_model.dart';
import '../../../../features/home/repositories/home_repositories.dart';

class SliderController extends GetxController{
  static SliderController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;
  final pageController = CarouselController();
  RxList homeSliders = [].obs;
  RxList homeSlidersLink = [].obs;

  @override
  void onInit() {
    fetchCarouselImages();
    super.onInit();
  }

  void updateCurrentIndex (index){
    carouselCurrentIndex.value = index;
  }

  // Future<HomeSlidersResponse> getSlidersData() async{
  //   return homeSliders.value = await HomeRepositories.getHomeSliders();
  // }

  fetchCarouselImages() async {
    var carouselResponse = await HomeRepositories.getHomeSliders();
    //print(carouselResponse);
    carouselResponse.data?.forEach((slider) {
      if(slider.photo != null) {
        homeSliders.add(slider.photo);
        homeSlidersLink.add(slider.link);
      }
    });
    // _isCarouselInitial = false;
    // setState(() {});
  }
}