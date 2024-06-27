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
  const AppQuestionCards(
      {super.key,
      required this.name,
      required this.time,
      required this.description});

  final String name, time, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const AppBannerImage(
                applyPadding: true,
                backgroundColor: AppColors.grey,
                applyImageRadius: true,
                boarderRadius: 100,
                height: 40,
                width: 40,
                imgUrl: AppImages.profileIcon),
            const Gap(AppSizes.sm),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: Theme.of(context).textTheme.bodyLarge!),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
         Padding(
          padding: const EdgeInsets.only(left: 35),
          child: AppQuestionDescriptionPart(description: description,),
        ),
      ],
    );
  }
}
