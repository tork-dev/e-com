import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/review/controller/review_controller.dart';
import 'package:torganic/src/features/review/view/widgets/review_desc.dart';
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
      return AppListViewLayout(
        itemCount: reviewController.apiHitting.value
            ? 5
            : reviewController.reviewResponse.value.data!.length,
        builderFunction: (context, index) => reviewController.apiHitting.value
            ? ShimmerHelper().buildBasicShimmer(height: 70)
            : Column(
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
                              isNetworkImage: reviewController.reviewResponse.value.data![index].avatar != null,
                              imgUrl: reviewController.reviewResponse.value.data![index].avatar ?? AppImages.profileIcon),
                          const Gap(AppSizes.sm),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reviewController.reviewResponse.value.data![index].userName ?? 'Guest',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge!),
                              Text(
                                reviewController.reviewResponse.value.data![index].time!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      RatingBar(
                        itemSize: 14.0,
                        ignoreGestures: true,
                        initialRating: reviewController.reviewResponse.value.data![index].rating!.toDouble(),
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full:
                              const Icon(Icons.star, color: AppColors.warning),
                          empty: const Icon(Icons.star, color: Colors.grey),
                          half:
                              const Icon(Icons.star, color: AppColors.warning),
                        ),
                        itemPadding: const EdgeInsets.only(right: 1.0),
                        onRatingUpdate: (rating) {
                          //print(rating);
                        },
                      ),
                    ],
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: AppReviewDescriptionPart(index: index,),
                  ),
                ],
              ),
      );
    });
  }
}
