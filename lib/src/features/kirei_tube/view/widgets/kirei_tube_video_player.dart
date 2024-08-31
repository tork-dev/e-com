// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:kirei/src/common/styles/skeleton_style.dart';
// import 'package:kirei/src/common/widgets/containers/banner_image.dart';
// import 'package:kirei/src/common/widgets/containers/card_container.dart';
// import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';
//
// import '../../../../utils/constants/colors.dart';
//
// class KireiDetailsVideoPlayer extends StatelessWidget {
//   const KireiDetailsVideoPlayer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final kireiTubeDetailsController = KireiTubeDetailsController.instance;
//
//     return Obx(() => kireiTubeDetailsController.hittingApi.value
//         ? ShimmerHelper().buildBasicShimmer(height: 200)
//         : SizedBox(
//             height: 200,
//             child: Stack(
//               children: [
//                 AppBannerImage(
//                   width: double.infinity,
//                   applyImageRadius: false,
//                   height: double.infinity,
//                   // Match the parent's height
//                   fit: BoxFit.cover,
//                   isNetworkImage: true,
//                   imgUrl: kireiTubeDetailsController
//                       .kireiTubeDetailsResponse.value.data!.banner,
//                 ),
//                 Center(
//                   child: AppCardContainer(
//                     height: 70,
//                     width: 70,
//                     applyRadius: false,
//                     isCircle: true,
//                     backgroundColor: AppColors.dark.withOpacity(.2),
//                     child: const Icon(
//                       Icons.play_circle_filled_sharp,
//                       color: AppColors.dark,
//                       size: 60,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';
import 'package:kirei/src/features/web_view/web_view.dart';

import 'package:webview_flutter/webview_flutter.dart';


// class KireiDetailsVideoPlayer extends StatelessWidget {
//   const KireiDetailsVideoPlayer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final videoController = KireiTubeDetailsController.instance;
//     return Obx(() {
//       return videoController.hittingApi.value
//           ? ShimmerHelper().buildBasicShimmer(height: 150)
//           : AppCardContainer(
//               child: WebViewScreen(title: '', url: '',)
//             );
//     });
//   }
// }


import 'package:kirei/src/utils/constants/colors.dart';


class KireiDetailsVideoPlayer extends StatefulWidget {
  final String url;

  const KireiDetailsVideoPlayer({super.key, required this.url});

  @override
  State<KireiDetailsVideoPlayer> createState() => _KireiDetailsVideoPlayerState();
}

class _KireiDetailsVideoPlayerState extends State<KireiDetailsVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    WebViewController controllers = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    return AppCardContainer(
      height: 250,
      child: WebViewWidget(
                controller: controllers,
              ),
    );
  }
}

