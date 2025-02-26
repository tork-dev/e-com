import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kirei/src/features/community/model/community_like_create_response.dart';
import 'package:kirei/src/features/community/model/create_community_post_response.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../utils/logging/logger.dart';
import '../model/community_response.dart';
import '../repositries/community_repositories.dart';

class CommunityController extends GetxController {
  static CommunityController get instance => Get.find();
  final GlobalKey<ScaffoldState> communityKey = GlobalKey<ScaffoldState>();

  TextEditingController communityFieldController = TextEditingController();

  final ScrollController scrollController = ScrollController();
  RxInt pageNumber = 1.obs;
  RxBool isLoading = false.obs;

  ///Model
  Rx<CommunityResponse> communityResponse = CommunityResponse().obs;
  Rx<NewCommunityPostResponse> createCommunityResponse =
      NewCommunityPostResponse().obs;
  Rx<AddCommunityLike> addCommunityLike = AddCommunityLike().obs;
  RxList<CommunityPost> communityPostList = <CommunityPost>[].obs;


  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    print('refresh');
    // pageNumber.value = 1;
    getCommunityResponse();
    addItems();
  }

  Future<void> getCommunityResponse() async {
    isLoading.value = true;
    communityResponse.value = await CommunityRepositories().getCommunityPost(pageNumber.value);
    if (communityResponse.value.data != null) {
      communityPostList.addAll(communityResponse.value.data ?? []);
      Log.i('all post : ${communityPostList.length}');
    }
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
    // if(imageFile == null){
    //   AppHelperFunctions.showToast('Please select a picture');
    //   return;
    // }
    print('going');
    try {
      isLoading.value = true;
      createCommunityResponse.value = await CommunityRepositories()
          .getNewCommunityPostResponse(
              imageFile: imageFile,
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

  Future<void> getAddCommunityLike(String postId) async {
    addCommunityLike.value =
        await CommunityRepositories().getCommunityLikeCreateResponse(postId);
  }

  bool isLoadingMore = false;

  void addItems() {
    scrollController.addListener(() {
        if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50 &&
          pageNumber.value < communityResponse.value.meta!.lastPage! &&
          !isLoadingMore &&
          !isLoading.value) {
        isLoadingMore = true; // Set loading flag to true

        AppHelperFunctions.showToast('Loading more...');
        print('Loading more data for page number: ${pageNumber.value}');

        // Save current scroll position and content height before loading more data
        double currentScrollPosition = scrollController.position.pixels;
        double maxScrollExtentBeforeLoad =
            scrollController.position.maxScrollExtent;

        pageNumber.value++;
        isLoading.value = true;

        getCommunityResponse();
        isLoading.value = false;
        isLoadingMore = false; // Reset loading flag

        double newMaxScrollExtent = scrollController.position.maxScrollExtent;
        double scrollOffsetDifference =
            newMaxScrollExtent - maxScrollExtentBeforeLoad;
        scrollController.jumpTo(currentScrollPosition +
            scrollOffsetDifference); // Maintain position after loading
      } else if (pageNumber.value >= communityResponse.value.meta!.lastPage! &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        AppHelperFunctions.showToast('No Post');
      }
    });
  }
}
