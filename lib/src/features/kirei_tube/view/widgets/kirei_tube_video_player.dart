import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';

import '../../../../utils/constants/colors.dart';

class KireiDetailsVideoPlayer extends StatelessWidget {
  const KireiDetailsVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final kireiTubeDetailsController = KireiTubeDetailsController.instance;

    return Obx(() => kireiTubeDetailsController.hittingApi.value
        ? ShimmerHelper().buildBasicShimmer(height: 200)
        : SizedBox(
            height: 200,
            child: Stack(
              children: [
                AppBannerImage(
                  width: double.infinity,
                  applyImageRadius: false,
                  height: double.infinity,
                  // Match the parent's height
                  fit: BoxFit.cover,
                  isNetworkImage: true,
                  imgUrl: kireiTubeDetailsController
                      .kireiTubeDetailsResponse.value.data!.banner,
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
          ));
  }
}
