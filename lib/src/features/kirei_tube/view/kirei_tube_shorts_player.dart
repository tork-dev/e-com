import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/layout_without_appbar/layout_without_appbar.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../common/styles/skeleton_style.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../controller/kirei_tube_details_controller.dart';

class KireiTubeShortsPlayer extends StatelessWidget {
  const KireiTubeShortsPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KireiTubeDetailsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shorts'),
        backgroundColor: Colors.transparent,
      ),
        body: AppCardContainer(
          height: AppHelperFunctions.screenHeight(),
            width: AppHelperFunctions.screenWidth(),
            child: Obx(() {
              return controller.hittingApi.value
                  ? ShimmerHelper().buildBasicShimmer(
                      height: AppHelperFunctions.screenHeight())
                  : controller.videoUrl.contains('facebook.com')
                      ? WebViewWidget(
                          controller: controller.webViewController!,
                        )
                      : YoutubePlayer(
                          controller: controller.youtubeController.value!,
                        );
            })));
  }
}
