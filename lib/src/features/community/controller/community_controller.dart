import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/community/repositries/community_repositories.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';

import '../model/community_response.dart';

class CommunityController extends GetxController{
  static CommunityController get instance => Get.find();
  final GlobalKey<ScaffoldState> communityKey = GlobalKey<ScaffoldState>();

  TextEditingController communityFieldController = TextEditingController();



  ConvexBottomNavController bottomController  = Get.put(ConvexBottomNavController());
  HomeController homeController  = Get.put(HomeController());
  final shopController = Get.put(ShopController());

  ///Model
  Rx<CommunityResponse> communityResponse = CommunityResponse().obs;

  @override
  void onInit() {
    super.onInit();
    homeController.callApis.value = false;
   onRefresh();
  }

  Future<void> onRefresh()async{
    print('refresh');
    getCommunityResponse();
  }

  Future<CommunityResponse> getCommunityResponse () async{
    return communityResponse.value = await CommunityRepositories().getCommunityPost();
  }


}