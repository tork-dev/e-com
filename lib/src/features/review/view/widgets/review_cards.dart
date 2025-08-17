import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/review/controller/review_controller.dart';
import 'package:kirei/src/features/review/view/widgets/review_desc.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class AppReviewCards extends StatelessWidget {
  const AppReviewCards({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewController = ReviewController.instance;

    return Obx(() {
      final isLoading = reviewController.apiHitting.value;
      final reviewList = reviewController.reviewResponse.value.data;

      if (isLoading) {
        // show shimmer
        return AppListViewLayout(
          itemCount: 10,
          builderFunction: (context, index) =>
              ShimmerHelper().buildBasicShimmer(height: 70.0),
        );
      }

      if (reviewList == null || reviewList.isEmpty) {
        // show "No reviews" message
        return const Center(
          child: Text("No reviews"),
        );
      }

      // otherwise show the reviews
      return AppListViewLayout(
        itemCount: reviewList.length,
        builderFunction: (context, index) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AppBannerImage(
                      applyPadding: true,
                      backgroundColor: AppColors.grey,
                      applyImageRadius: true,
                      boarderRadius: 100,
                      height: 50,
                      width: 50,
                      isNetworkImage: reviewList[index].avatar != null,
                      imgUrl:
                      reviewList[index].avatar ?? AppImages.profileIcon,
                    ),
                    const Gap(AppSizes.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reviewList[index].userName ?? 'Guest',
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                        Text(
                          reviewList[index].time ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                RatingBar(
                  itemSize: 14.0,
                  ignoreGestures: true,
                  initialRating: reviewList[index].rating?.toDouble() ?? 0.0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: AppColors.warning),
                    empty: const Icon(Icons.star, color: Colors.grey),
                    half: const Icon(Icons.star, color: AppColors.warning),
                  ),
                  itemPadding: const EdgeInsets.only(right: 1.0),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: AppReviewDescriptionPart(index: index),
            ),
          ],
        ),
      );
    });
  }

}
