import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/utils/constants/colors.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class InfluencerHeaderPart extends StatelessWidget {
  const InfluencerHeaderPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: Stack(
        children: [
          AppBannerImage(
              width: AppHelperFunctions.screenWidth(),
              height: 128,
              applyImageRadius: false,
              imgUrl: AppImages.influencerBg),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace),
            child: ListTile(
              isThreeLine: true,
              leading: const AppBannerImage(
                height: 50,
                width: 50,
                applyImageRadius: true,
                imgBoarderRadius: 100,
                boarderRadius: 100,
                hasBorder: true,
                borderWidth: 2,
                borderColor: AppColors.addToCartButton,
                imgUrl:  AppImages.avatarIcon,
              ),
              title: Text('Ishyaa Tahsin', style: Theme.of(context).textTheme.bodyLarge,),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("I've seen a lot of designs with busy elements", style: Theme.of(context).textTheme.labelLarge,),
                  const Gap(AppSizes.md),
                  const Row(
                    children: [
                      AppBannerImage(imgUrl: AppImages.facebookInIcon),
                      Gap(AppSizes.spaceBtwDefaultItems),
                      AppBannerImage(imgUrl: AppImages.twitterInIcon),
                      Gap(AppSizes.spaceBtwDefaultItems),
                      AppBannerImage(imgUrl: AppImages.instagramInIcon),
                      Gap(AppSizes.spaceBtwDefaultItems),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}