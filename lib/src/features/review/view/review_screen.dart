import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/review/controller/review_controller.dart';
import 'package:kirei/src/features/review/view/widgets/review_cards.dart';
import 'package:kirei/src/features/review/view/widgets/review_post_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class ReviewScreen extends StatelessWidget {
  final String productId;
  const ReviewScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final ReviewController controller = Get.put(ReviewController(productId: productId));
    return AppLayoutWithBackButton(
        // bodyBackgroundColor: Colors.grey[100],
        title: const Text(
          'Reviews',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        padding: 0,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
              child: AppLayoutWithRefresher(
                  onRefresh: controller.onRefresh,
                  children: const [
                    SizedBox(
                      height: 500,
                        child: AppReviewCards()),
                  ]),
            ),
            const Positioned(
                bottom: 0,
                child: AppReviewPostCard()),

          ],
        ));
  }
}
