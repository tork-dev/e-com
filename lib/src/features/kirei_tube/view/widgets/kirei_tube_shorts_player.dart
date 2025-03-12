import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../controller/kirei_tube_details_controller.dart';

class KireiTubeShortsPlayer extends StatelessWidget {
  const KireiTubeShortsPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = KireiTubeDetailsController.instance;
    return Obx(() {
      return controller.hittingApi.value
          ? ShimmerHelper().buildBasicShimmer(
            height: AppHelperFunctions.screenHeight() * .6,
          )
          : AppCardContainer(
        height: controller.aspectRatio.value < 1? AppHelperFunctions.screenHeight() * .6 : null,
            child: AspectRatio(
              aspectRatio:
                  controller.aspectRatio.value,
              child:
                  controller.videoUrl.contains('facebook.com')
                      ? WebViewWidget(controller: controller.webViewController!)
                      : YoutubePlayer(
                        controller: controller.youtubeController.value!,
                      ),
            ),
          );
    });
  }
}
