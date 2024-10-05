import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class HomeReviewSection extends StatelessWidget {
  const HomeReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return Obx(() {
      return AppCardContainer(
        applyRadius: false,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          children: [
            const Gap(AppSizes.defaultSpace),
            const AppSectionTitleText(
              sectionTitle: 'Customer’s Review',
              haveTxtButton: false,
            ),
            const Gap(AppSizes.spaceBtwDefaultItems),
            SizedBox(
              height: 200,
              child: AppListViewLayout(
                  itemCount: homeController.hittingApi.value
                      ? 5
                      : homeController
                          .homeProductResponse.value.reviews!.length,
                  isScrollVertically: false,
                  builderFunction: (context, index) {
                    return AppCardContainer(
                        width: 280,
                        applyRadius: false,
                        backgroundColor: AppColors.whitePink,
                        padding: const EdgeInsets.all(AppSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  foregroundImage: NetworkImage(''),
                                ),
                                const Gap(AppSizes.spaceBtwDefaultItems),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name', style: Theme.of(context).textTheme.titleLarge,),
                                    const Gap(AppSizes.xs),
                                    Text('Designation', style: Theme.of(context).textTheme.labelMedium,)
                                  ],
                                )
                              ],
                            ),
                            const Gap(AppSizes.spaceBtwDefaultItems),
                            homeController.hittingApi.value
                                ? ShimmerHelper()
                                    .buildBasicShimmer(height: 20, width: 250)
                                : RatingBar.builder(
                                    initialRating: double.parse(homeController
                                        .homeProductResponse
                                        .value
                                        .reviews![index]
                                        .rating
                                        .toString()),
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemSize: AppSizes.iconMd,
                                    glowColor: AppColors.light,
                                    unratedColor: AppColors.accent,
                                    itemPadding: EdgeInsets.zero,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: AppColors.primary,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                            const Gap(AppSizes.sm),
                            Expanded(
                              child: homeController.hittingApi.value
                                  ? ShimmerHelper().buildBasicShimmer(
                                      height: 100, width: 300)
                                  : Text(
                                      homeController.homeProductResponse.value
                                              .reviews![index].comment ??
                                          '',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ],
                        ));
                  }),
            )
          ],
        ),
      );
    });
  }
}
