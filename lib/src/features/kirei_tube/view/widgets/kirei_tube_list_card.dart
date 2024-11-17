import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class KireiTubeListCard extends StatelessWidget {
  const KireiTubeListCard({
    this.kireiTubeBanner,
    this.kireiTubeTitle,
    this.kireiTubePlaylistVideoCount,
    this.onTapBanner,
    required this.isPlaylist,
    this.onTapViewPlaylist,
    super.key,
  });

  final String? kireiTubeBanner,
      kireiTubeTitle,
      kireiTubePlaylistVideoCount;
  final bool isPlaylist;
  final VoidCallback? onTapBanner;
  final VoidCallback? onTapViewPlaylist;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      backgroundColor: AppColors.white,
      applyRadius: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AspectRatio to maintain image proportions and control Stack layout
          InkWell(
            onTap: isPlaylist? onTapViewPlaylist: onTapBanner,
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
                          padding: const EdgeInsets.symmetric(
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
              child: InkWell(
                onTap: onTapViewPlaylist,
                child: Text(
                  'View full playlist',
                  style:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(height: 0),
                ),
              )),
        ],
      ),
    );
  }
}
