import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class CommunityPostContainer extends StatelessWidget {
  const CommunityPostContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        backgroundColor: AppColors.white,
        padding: const EdgeInsets.all(AppSizes.md),
        applyShadow: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const AppBannerImage(
                    applyPadding: true,
                    hasBorder: true,
                    borderColor: Colors.transparent,
                    backgroundColor: AppColors.grey,
                    borderWidth: 1,
                    applyImageRadius: true,
                    boarderRadius: 100,
                    height: 60,
                    width: 60,
                    imgUrl: AppImages.profileIcon),
                const Gap(AppSizes.sm),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mehtab Sultana', style: Theme.of(context).textTheme.titleLarge!.apply(color: AppColors.darkGrey),),
                    Text('2 week ago', style: Theme.of(context).textTheme.bodySmall,),
                  ],)
              ],
            ),
            const Gap(AppSizes.sm),
            const Text('is there any haircare product available'),
            const Gap(AppSizes.sm),
            const Center(
              child: AppBannerImage(
                  height: 150,
                  applyImageRadius: false,
                  imgUrl: AppImages.kireiYoutube),
            ),
            const Gap(AppSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0 Comment'),
                SizedBox(
                  child: Row(children: [
                    Icon(Icons.favorite, size: 30, color: AppColors.darkGrey,),
                    Gap(AppSizes.sm),
                    Text('love', style: Theme.of(context).textTheme.bodySmall)
                  ],),
                )
              ],)
          ],
        ));
  }
}