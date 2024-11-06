import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/kirei_tube_controller.dart';

class KireiTubeListCard extends StatelessWidget {
  const KireiTubeListCard({
    this.kireiTubeBanner,
    this.kireiTubeTitle,
    this.kireiTubeViewsCount,
    this.kireiTubeLikeCount,
    this.kireiTubeCommentCount,
    this.kireiTubePlaylistVideoCount,
    required this.onTapBanner,
    required this.isPlaylist,
    super.key,
  });

  final String? kireiTubeBanner,
      kireiTubeTitle,
      kireiTubeViewsCount,
      kireiTubeLikeCount,
      kireiTubeCommentCount,
      kireiTubePlaylistVideoCount;
  final bool isPlaylist;
  final VoidCallback onTapBanner;

  @override
  Widget build(BuildContext context) {
    final kireiTubeController = KireiTubeController.instance;
    return AppCardContainer(
      backgroundColor: AppColors.white,
      applyRadius: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AspectRatio to maintain image proportions and control Stack layout
          InkWell(
            onTap: onTapBanner,
            child: AspectRatio(
              aspectRatio: 16 / 9, // 16:9 aspect ratio for the image
              child: Stack(
                children: [
                  AppBannerImage(
                    width: double.infinity,
                    applyImageRadius: false,
                    height: double.infinity,
                    // Match the parent's height
                    fit: BoxFit.cover,
                    isNetworkImage: true,
                    imgUrl: kireiTubeBanner,
                  ),
                  Visibility(
                    visible: !isPlaylist,
                    child: Center(
                      child: AppCardContainer(
                        height: 70,
                        width: 70,
                        applyRadius: false,
                        isCircle: true,
                        backgroundColor: AppColors.dark.withOpacity(.2),
                        child: const Icon(
                          Icons.play_circle_filled_sharp,
                          color: AppColors.dark,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isPlaylist,
                    child: Positioned(
                        right: AppSizes.xs,
                        bottom: AppSizes.xs,
                        child: AppCardContainer(
                          backgroundColor: AppColors.white,
                          applyRadius: false,
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.xs, vertical: 3),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.queue_music_sharp),
                              const Gap(AppSizes.xs),
                              Text('$kireiTubePlaylistVideoCount videos')
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
          const Gap(AppSizes.sm),
          SizedBox(
            height: 40,
            child: Text(
              kireiTubeTitle ?? '',
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const Gap(AppSizes.sm),
          Visibility(
              visible: isPlaylist,
              child: Text(
                'View full playlist',
                style:
                    Theme.of(context).textTheme.bodyMedium!.copyWith(height: 0),
              )),
          Visibility(
            visible: !isPlaylist,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${NumberFormat.compact().format(int.parse(kireiTubeViewsCount ?? '0'))} Views",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  "${NumberFormat.compact().format(int.parse(kireiTubeLikeCount ?? '0'))} Likes",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  "${NumberFormat.compact().format(int.parse(kireiTubeCommentCount ?? '0'))} Comments",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          const Gap(AppSizes.md),
        ],
      ),
    );
  }
}
