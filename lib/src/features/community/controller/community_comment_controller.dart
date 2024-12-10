import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/community/model/create_community_post_response.dart';
import 'package:kirei/src/features/community/repositries/community_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../model/community_comment_response.dart';

class CommunityCommentController extends GetxController {
  static CommunityCommentController get instance => Get.find();
  final int postId;

  CommunityCommentController({required this.postId});

  TextEditingController commentController = TextEditingController();
  Rx<CommunityCommentResponse> communityCommentResponse =
      CommunityCommentResponse().obs;
  Rx<NewCommunityPostResponse> communityCommentAddResponse =
      NewCommunityPostResponse().obs;
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCommunityPost();
  }

  Future<void> getCommunityPost() async {
    isLoading.value = true;
    communityCommentResponse.value =
        await CommunityRepositories().getCommunityComment(postId);
    isLoading.value = false;
  }

  Future<void> addCommunityComment() async {
    if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != true){
      Get.to('/login/community');
      return;
    }
    communityCommentAddResponse.value = await CommunityRepositories()
        .getCommunityCommentCreateResponse(commentController.text, postId);
   commentController.clear();
   getCommunityPost();
    AppHelperFunctions.showToast(communityCommentAddResponse.value.message!);
  }
}
