import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/features/questions/view/widgets/question_desc.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class AppQuestionCards extends StatelessWidget {
  const AppQuestionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const AppBannerImage(
                    applyPadding: true,
                    backgroundColor: AppColors.grey,
                    applyImageRadius: true,
                    boarderRadius: 100,
                    height: 50,
                    width: 50,
                    imgUrl: AppImages.profileIcon),
                const Gap(AppSizes.sm),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mehtab Sultana',
                        style: Theme.of(context).textTheme.bodyLarge!),
                    Text(
                      '2 week ago',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            RatingBar(
              itemSize: 14.0,
              ignoreGestures: true,
              initialRating: 3.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: AppColors.warning),
                empty: const Icon(Icons.star, color: Colors.grey),
                half: const Icon(Icons.star, color: AppColors.warning),
              ),
              itemPadding: const EdgeInsets.only(right: 1.0),
              onRatingUpdate: (rating) {
                //print(rating);
              },
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 40),
          child: AppQuestionDescriptionPart(),
        ),
      ],
    );
  }
}
