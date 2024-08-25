import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class HomeNewSections extends StatelessWidget {
  const HomeNewSections({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        child: Column(
      children: [
        const AppBannerImage(imgUrl: 'assets/images/demo/new_section_img.png'),
        Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI-Powered Skin Care Recommendations',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(AppSizes.spaceBtwDefaultItems),
                Text(
                  'Discover the perfect skin care products tailored just for you with our innovative AI Skin Recommendation feature Our advanced',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Gap(AppSizes.defaultSpace),
                AppCardContainer(
                  backgroundColor: AppColors.secondary,
                    applyRadius: false,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.defaultSpace,
                        vertical: AppSizes.spaceBtwDefaultItems),
                    child: Text(
                      'Start Personalized Test',
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.white),
                    ))
              ],
            )),
      ],
    ));
  }
}
