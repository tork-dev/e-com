import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class HomeReviewSection extends StatelessWidget {
  const HomeReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      applyRadius: false,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        children: [
          const AppSectionTitleText(
            sectionTitle: 'Customer’s Reviews',
            haveTxtButton: false,
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          SizedBox(
            height: 191,
            child: AppListViewLayout(
                itemCount: 5,
                isScrollVertically: false,
                builderFunction: (context, index) {
                  return AppCardContainer(
                      width: 280,
                      applyRadius: false,
                      backgroundColor: AppColors.lightGrey,
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBar(
                            itemSize: 24,
                            ignoreGestures: true,
                            initialRating: 3.4,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: const Icon(Icons.star,
                                  color: AppColors.primary),
                              empty: const Icon(Icons.star,
                                  color: AppColors.darkGrey),
                              half: const Icon(Icons.star,
                                  color: AppColors.primary),
                            ),
                            itemPadding: const EdgeInsets.only(right: 4.0),
                            onRatingUpdate: (rating) {
                              //print(rating);
                            },
                          ),
                          const Gap(AppSizes.sm),
                          Text(
                            'At our digital agency, we understand the importance of a well-designed and functional website. Website as the digital storefront for business understand the importance.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Gap(AppSizes.spaceBtwDefaultItems),
                          Text(
                            'Fatema khatun',
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ));
                }),
          )
        ],
      ),
    );
  }
}
