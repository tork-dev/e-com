import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class VideoHorizontalCard extends StatelessWidget {
  const VideoHorizontalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        applyRadius: false,
        padding: const EdgeInsets.all(AppSizes.sm),
        backgroundColor: AppColors.lightGrey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBannerImage(
                width: 104,
                height: 66,
                isNetworkImage: true,
                applyImageRadius: false,
                imgUrl:
                'https://appbeta.kireibd.com/storage/blogs/banner/66b8a02d7b9a6.png'),
            const Gap(AppSizes.spaceBtwDefaultItems),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    'How Melano CC Essence r e m o v ed. dsfasfasf.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'KireiBd',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '11 Month ago',
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ));
  }
}