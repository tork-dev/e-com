import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kirei/src/features/community/model/community_like_create_response.dart';
import 'package:kirei/src/features/community/model/create_community_post_response.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../model/community_response.dart';
import '../repositries/community_repositories.dart';

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
  Rx<NewCommunityPostResponse> createCommunityResponse =
      NewCommunityPostResponse().obs;
  Rx<AddCommunityLike> addCommunityLike = AddCommunityLike().obs;

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
    communityResponse.value = await CommunityRepositories().getCommunityPost();
    isLoading.value = false;
  }

  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  RxString imageName = ''.obs;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      AppHelperFunctions.showToast('No picture selected');
      return;
    }
    imageFile = File(pickedFile.path);
    imageName.value = pickedFile.path.split("/").last;
  }

  Future<void> createCommunityPost() async {
    if (communityFieldController.text == '') {
      AppHelperFunctions.showToast('Please write something');
      return;
    }
    if(imageFile == null){
      AppHelperFunctions.showToast('Please select a picture');
      return;
    }
    try {
      isLoading.value = true;
      createCommunityResponse.value = await CommunityRepositories()
          .getNewCommunityPostResponse(
              imageFile: imageFile!,
              filename: imageName.value,
              description: communityFieldController.text);
      AppHelperFunctions.showToast(createCommunityResponse.value.message!);
      await getCommunityResponse();
      isLoading.value = false;
      communityFieldController.clear();
      imageName.value = '';
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }

  Future<void> getAddCommunityLike(String postId)async{
    addCommunityLike.value = await CommunityRepositories().getCommunityLikeCreateResponse(postId);
  }


}
