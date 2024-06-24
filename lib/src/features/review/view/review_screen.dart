import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/features/review/controller/review_controller.dart';
import 'package:torganic/src/features/review/view/widgets/review_cards.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewController controller = Get.put(ReviewController());
    return AppLayoutWithBackButton(
     // bodyBackgroundColor: Colors.grey[100],
        title: const Text(
          'Reviews',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        padding: AppSizes.defaultSpace,
        body: AppLayoutWithRefresher(
            onRefresh: controller.onRefresh,
            children: [
              AppReviewCards()
            ]));
  }
}
