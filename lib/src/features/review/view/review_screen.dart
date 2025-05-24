import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/review/controller/review_controller.dart';
import 'package:kirei/src/features/review/view/widgets/review_cards.dart';
import 'package:kirei/src/features/review/view/widgets/review_post_card.dart';
import 'package:kirei/src/features/review/view/widgets/user_review.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../../utils/helpers/helper_functions.dart';

class ReviewScreen extends StatelessWidget {
  final String productId;

  const ReviewScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final ReviewController controller = Get.put(
      ReviewController(productId: productId),
    );
    return AppLayoutWithBackButton(
      // bodyBackgroundColor: Colors.grey[100],
      title: const Text('Reviews', style: TextStyle(color: AppColors.primary)),
      centerTitle: true,
      leadingIconColor: AppColors.darkGrey,
      padding: 0,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
            child: AppLayoutWithRefresher(
              onRefresh: controller.onRefresh,
              children: [
                AppReviewCards(),
                Gap(200)
              ],
            ),
          ),
          Obx(() {
            return Positioned(
              bottom: 0,
              child:
                  controller.reviewResponse.value.canReview ?? true
                      ? AppReviewPostCard()
                      : UserReview(
                        reviewerName: "${controller.reviewResponse.value.loggerReview?.userName}",
                        reviewText: "${controller.reviewResponse.value.loggerReview?.comment}",
                        rating: controller.reviewResponse.value.loggerReview?.rating?.toDouble() ?? 0,
                        status: controller.reviewResponse.value.loggerReview?.isApproved ?? 0,
                      ),
            );
          }),
        ],
      ),
    );
  }
}
