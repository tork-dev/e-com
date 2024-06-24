import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/review/model/review_response_model.dart';
import 'package:torganic/src/features/review/model/review_submit_response.dart';
import 'package:torganic/src/features/review/repositories/review_repositories.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();

  final int productId;

  ReviewController({required this.productId});

  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();


  Rx<ReviewResponse> reviewResponse = ReviewResponse().obs;
  Rx<ReviewSubmitResponse> reviewSubmitResponse = ReviewSubmitResponse().obs;


  RxDouble givenRating = 1.0.obs;
  RxBool apiHitting = false.obs;
  RxInt pageNumber = 1.obs;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    apiHitting.value = true;
    await getReviewData();
    apiHitting.value = false;
  }


  Future<ReviewResponse> getReviewData() async {
    return reviewResponse.value =
    await ReviewRepositories().getReviewResponse(
        productId: productId, pageNumber: pageNumber.value);
  }

  Future<void> submitReview() async {

    if(nameController.text == ''){
      AppHelperFunctions.showToast('Please enter your name');
      return;
    }
    if(commentController.text == ''){
      AppHelperFunctions.showToast('Please enter a comment');
      return;
    }
    if(givenRating.value < 1){
      AppHelperFunctions.showToast('Please enter us a star');
      return;
    }
    try {
      apiHitting.value = true;
      reviewSubmitResponse.value =
      await ReviewRepositories().getReviewSubmitResponse(
          productId: productId,
          rating: givenRating.value.toInt(),
          comment: commentController.text.toString(),
          guestUserName: nameController.text.toString());
      apiHitting.value = true;
      givenRating.value = 1;
      nameController.text = '';
      commentController.text = '';
      AppHelperFunctions.showToast(reviewSubmitResponse.value.message!);
    } catch (e) {
      print(e.toString());
    }
  }
}