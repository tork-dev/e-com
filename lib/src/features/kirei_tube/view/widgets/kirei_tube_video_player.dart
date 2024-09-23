import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../controller/kirei_tube_details_controller.dart';

class KireiDetailsVideoPlayer extends StatelessWidget {
  const KireiDetailsVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = KireiTubeDetailsController.instance;
    return AppCardContainer(
        height: 250,
        child: Obx(() {
          return controller.flickManager.value == null
              ? ShimmerHelper().buildBasicShimmer()
              : SizedBox(
            height: 250,
                child: FlickVideoPlayer(
                    flickManager: controller.flickManager.value!,
                  ),
              );
        }));
  }
}
