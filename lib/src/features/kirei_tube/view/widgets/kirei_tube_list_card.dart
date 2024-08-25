import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/kirei_tube_controller.dart';

class KireiTubeListCard extends StatelessWidget {
  const KireiTubeListCard({super.key, required this.index});

  final int index;

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
            onTap: () => Get.toNamed(
                '/kirei-tube/${kireiTubeController.videoList.value.data![index].slug}'),
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
                    imgUrl:
                        kireiTubeController.videoList.value.data![index].banner,
                  ),
                   Center(
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
                ],
              ),
            ),
          ),
          const Gap(AppSizes.sm),
          Text(
            kireiTubeController.videoList.value.data![index].title!,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const Gap(AppSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${NumberFormat.compact().format(int.parse(kireiTubeController.videoList.value.data![index].statistics?.viewCount ?? '0'))} Views" '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "${NumberFormat.compact().format(int.parse(kireiTubeController.videoList.value.data![index].statistics?.likeCount ?? '0'))} Likes",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "${NumberFormat.compact().format(int.parse(kireiTubeController.videoList.value.data![index].statistics?.commentCount ?? '0'))} Comments",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Gap(AppSizes.md),
        ],
      ),
    );
  }
}
