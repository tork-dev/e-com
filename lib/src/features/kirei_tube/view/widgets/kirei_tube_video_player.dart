import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../controller/kirei_tube_details_controller.dart';

class KireiDetailsVideoPlayer extends StatelessWidget {
  const KireiDetailsVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = KireiTubeDetailsController.instance;
    return AppCardContainer(
        height: 250,
        child: Obx(() {

          return controller.hittingApi.value? ShimmerHelper().buildBasicShimmer(height: 250) :
            controller.kireiTubeDetailsResponse.value.data!.video!.contains('www.facebook.com')?


            controller.youtubeController.value == null
              ? ShimmerHelper().buildBasicShimmer()
              : SizedBox(
            height: 250,
                child: YoutubePlayer(
                    controller: controller.youtubeController.value!,
                  ),
              );
        }));
  }
}
