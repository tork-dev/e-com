import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../controller/kirei_tube_details_controller.dart';

class KireiDetailsVideoPlayer extends StatelessWidget {
  const KireiDetailsVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = KireiTubeDetailsController.instance;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: AppCardContainer(child: Obx(() {
        return controller.hittingApi.value
            ? ShimmerHelper().buildBasicShimmer(height: 250)
            : controller.videoUrl.contains('facebook.com')
                ? WebViewWidget(
                    controller: controller.webViewController!,
                  )
                : YoutubePlayer(
                    aspectRatio: 16 / 9,
                    controller: controller.youtubeController.value!,
                  );
      })),
    );
  }
}
