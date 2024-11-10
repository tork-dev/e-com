import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import 'widgets/video_horizontal_card.dart';

class KireiTubePlaylistScreen extends StatelessWidget {
  const KireiTubePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayoutWithBackButton(
        title: const Text('Playlist'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBannerImage(
                  height: 215,
                  applyImageRadius: false,
                  isNetworkImage: true,
                  imgUrl:
                      'https://appbeta.kireibd.com/storage/blogs/banner/66b8a02d7b9a6.png'),
              const Gap(AppSizes.spaceBtwDefaultItems),
              Text(
                'Title',
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(AppSizes.sm),
              Row(
                children: [
                  const AppBannerImage(
                    height: AppSizes.iconLg,
                    width: AppSizes.iconLg,
                    imgBoarderRadius: 100,
                    boarderRadius: 100,
                    fit: BoxFit.contain,
                    backgroundColor: AppColors.lightGrey,
                    imgUrl: AppImages.lightAppLogo,
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  Text(
                    'by KireiBD',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              const Gap(AppSizes.spaceBtwItems),
              AppCardContainer(
                  applyRadius: false,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md, vertical: 6),
                  backgroundColor: AppColors.addToCartButton,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Playlist',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: AppColors.white),
                      ),
                      const Gap(AppSizes.spaceBtwDefaultItems),
                      Text('1 Video',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: AppColors.white)),
                      const Gap(AppSizes.spaceBtwDefaultItems),
                      Text('999 Views',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: AppColors.white))
                    ],
                  )),
              const Gap(AppSizes.spaceBtwSections),
              VideoHorizontalCard()
            ],
          ),
        ));
  }
}


