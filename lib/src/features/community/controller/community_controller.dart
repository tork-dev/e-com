
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/community/model/create_community_post_response.dart';
import 'package:kirei/src/features/community/repositries/community_repositories.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../model/community_response.dart';

class CommunityController extends GetxController {
  static CommunityController get instance => Get.find();
  final GlobalKey<ScaffoldState> communityKey = GlobalKey<ScaffoldState>();

  TextEditingController communityFieldController = TextEditingController();


  // ConvexBottomNavController bottomController = Get.put(ConvexBottomNavController());

  // HomeController homeController = Get.put(HomeController());
  // final shopController = Get.put(ShopController());

  RxBool isLoading = false.obs;

  ///Model
  Rx<CommunityResponse> communityResponse = CommunityResponse().obs;
  Rx<
      NewCommunityPostResponse> createCommunityResponse = NewCommunityPostResponse()
      .obs;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    print('refresh');
    getCommunityResponse();
  }

  Future<void> getCommunityResponse() async {
    isLoading.value = true;
    communityResponse.value =
    await CommunityRepositories().getCommunityPost();
    isLoading.value = false;
  }


  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  RxString imageName = ''.obs;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile == null){
      AppHelperFunctions.showToast('No image selected');
      return;
    }
    imageFile = File(pickedFile.path);
    imageName.value = pickedFile.path
        .split("/")
        .last;
  }

  Future<void> createCommunityPost() async{
    if(communityFieldController.text == ''){
      AppHelperFunctions.showToast('Please write something');
      return;
    }
    try{
      isLoading.value = true;
      createCommunityResponse.value = await CommunityRepositories().getNewCommunityPostResponse(
          imageFile: imageFile!,
          filename: imageName.value,
          description: communityFieldController.text);
      await getCommunityResponse();
      isLoading.value = false;
      communityFieldController.clear();
      imageName.value = '';
    }catch(e){
      print(e.toString());
      isLoading.value = false;
    }
  }





}