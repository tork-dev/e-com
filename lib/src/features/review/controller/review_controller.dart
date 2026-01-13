import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/review/model/review_response_model.dart';
import 'package:kirei/src/features/review/model/review_submit_response.dart';
import 'package:kirei/src/features/review/repositories/review_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../../utils/logging/logger.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();

  final String productId;

  ReviewController({required this.productId});

  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Rx<ReviewResponse> reviewResponse = ReviewResponse().obs;
  Rx<ReviewSubmitResponse> reviewSubmitResponse = ReviewSubmitResponse().obs;

  // Accumulated list of reviews for pagination
  RxList<Review> allReviews = <Review>[].obs;

  RxDouble givenRating = 5.0.obs;
  RxBool apiHitting = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;
  RxInt pageNumber = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
    onRefresh();
  }

  @override
  void onClose() {
    scrollController.dispose();
    nameController.dispose();
    commentController.dispose();
    super.onClose();
  }

  /// Sets up scroll listener to trigger pagination when near bottom
  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });
  }

  /// Refresh - resets to page 1 and clears existing reviews
  Future<void> onRefresh() async {
    apiHitting.value = true;
    pageNumber.value = 1;
    hasMore.value = true;
    allReviews.clear();
    await getReviewData();
    apiHitting.value = false;
  }

  /// Load more reviews when scrolling
  Future<void> loadMore() async {
    // Prevent multiple simultaneous loads or loading when no more data
    if (isLoadingMore.value || !hasMore.value || apiHitting.value) return;

    isLoadingMore.value = true;
    pageNumber.value++;
    await getReviewData();
    isLoadingMore.value = false;
  }

  Future<ReviewResponse> getReviewData() async {
    final response = await ReviewRepositories().getReviewResponse(
      productId: productId,
      pageNumber: pageNumber.value,
    );

    // Update the main response (for metadata like canReview, loggerReview)
    reviewResponse.value = response;

    // Accumulate reviews
    if (response.data != null && response.data!.isNotEmpty) {
      allReviews.addAll(response.data!);
    }

    // Check if there are more pages
    if (response.meta != null) {
      hasMore.value = response.meta!.currentPage! < response.meta!.lastPage!;
    } else {
      hasMore.value = false;
    }

    return response;
  }

  Future<void> submitReview() async {
    if (nameController.text == '') {
      AppHelperFunctions.showToast('Please enter your name');
      return;
    }
    if (commentController.text == '') {
      AppHelperFunctions.showToast('Please enter a comment');
      return;
    }
    // Check minimum 15 words
    final wordCount = commentController.text
        .trim()
        .split(RegExp(r'\s+'))
        .length;
    if (wordCount < 15) {
      AppHelperFunctions.showToast(
        'Please write at least 15 words in your review',
      );
      return;
    }
    if (givenRating.value < 1) {
      AppHelperFunctions.showToast('Please enter us a star');
      return;
    }
    try {
      apiHitting.value = true;
      reviewSubmitResponse.value = await ReviewRepositories()
          .getReviewSubmitResponse(
            productId: productId,
            rating: givenRating.value.toInt(),
            comment: commentController.text.toString(),
            guestUserName: nameController.text.toString(),
          );
      if (reviewSubmitResponse.value.result == true) {
        // EventLogger().logReviewEvent(
        //     itemId: productId,
        //     rating: givenRating.value.toString(),
        //     feedback: commentController.text.toString());
      }
      apiHitting.value = false;
      givenRating.value = 1;
      nameController.text = '';
      commentController.text = '';
      AppHelperFunctions.showToast(reviewSubmitResponse.value.message!);
    } catch (e) {
      Log.d(e.toString());
    }
  }
}
