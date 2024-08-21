import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/kirei_tube_screen.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

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
          children: [
            Stack(
              children: [
                AppBannerImage(
                    applyImageRadius: false,
                    height: 100,
                    fit: BoxFit.cover,
                    isNetworkImage: true,
                    imgUrl: kireiTubeController
                        .videoList.value.data![index].banner),
              ],
            ),
            const Gap(AppSizes.sm),
            Text(kireiTubeController.videoList.value.data![index].title!, overflow: TextOverflow.ellipsis, maxLines: 2,),
            const Gap(AppSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${kireiTubeController.videoList.value.data![index].statistics!.viewCount!} Views", style: Theme.of(context).textTheme.labelSmall,),
                Text("${kireiTubeController.videoList.value.data![index].statistics!.likeCount!} Likes", style: Theme.of(context).textTheme.labelSmall,),
                Text("${kireiTubeController.videoList.value.data![index].statistics!.commentCount!} Comments", style: Theme.of(context).textTheme.labelSmall,)
              ],
            )
          ],
        ));
  }
}
