import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class VideoHorizontalCard extends StatelessWidget {
  final String? imgUrl, title;
  final VoidCallback? onTap;

  const VideoHorizontalCard({
    this.imgUrl,
    this.title,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        onTap: onTap,
        applyRadius: false,
        padding: const EdgeInsets.all(AppSizes.sm),
        backgroundColor: AppColors.lightGrey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBannerImage(
                width: 104,
                height: 70,
                isNetworkImage: true,
                applyImageRadius: false,
                imgUrl: imgUrl ?? ''),
            const Gap(AppSizes.spaceBtwDefaultItems),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    title ?? '',
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
