import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/controller/common_controller.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  RxBool spinnerActive = false.obs;

  ///Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;


  /// Update Current Index when Page Scroll
  void updatePageIndicator(int index){
    currentPageIndex.value = index;
  }

  /// Jump To specific Page
  void dotNavigationClick(int index){
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Update Current Index & Jump To Next Page
  void nextPage(){
    if(currentPageIndex.value == 2){
      spinnerActive.value = true;
      AppLocalStorage().saveDataIfNull(LocalStorageKeys.isNotFirstTime, true);
      CommonController().showPopUp();
      Get.offAllNamed("/home");
    }else{
      int page = currentPageIndex.value +1;
      pageController.jumpToPage(page);
    }
  }

  /// Skip on-boarding pages
  void skipPage(){
    spinnerActive.value = true;
    AppLocalStorage().saveDataIfNull(LocalStorageKeys.isNotFirstTime, true);
    CommonController().showPopUp();
    Get.offAllNamed("/home");
  }
}