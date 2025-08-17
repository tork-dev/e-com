import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_details_model.dart';
import 'package:kirei/src/features/kirei_tube/repositories/kirei_tube_repositories.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class KireiTubeDetailsController extends GetxController {
  static KireiTubeDetailsController get instance => Get.find();

  RxBool hittingApi = false.obs;
  RxString orientation = 'portrait'.obs;
  Rx<KireiTubeDetailsResponse> kireiTubeDetailsResponse =
      KireiTubeDetailsResponse().obs;
  Rx<YoutubePlayerController?> youtubeController =
      Rx<YoutubePlayerController?>(null);
  RxString videoSlug = ''.obs;
  RxString videoUrl = ''.obs;
  RxDouble aspectRatio = 0.0.obs;
  WebViewController? webViewController;

  void setVideoUrl(String url) {
    videoUrl.value = url;
    Uri uri = Uri.parse(url);
    final int height = int.parse(uri.queryParameters["height"] ?? "16");
    final int width = int.parse(uri.queryParameters["width"] ?? "9");
    aspectRatio.value = width / height;
    Log.i("video url ${videoUrl.value}, aspect ratio ${aspectRatio.value}");
  }

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      videoSlug.value = Get.arguments['id']!;
      // orientation.value = Get.arguments['orientation']!;
    }
    else{
    videoSlug.value = Get.parameters['id']!;
    }

    if (videoSlug.isNotEmpty) {
      onRefresh();
    }
    Log.d('hitting youtube api');
  }

  @override
  void dispose() {
    super.dispose();
    if (!videoUrl.value.contains('facebook.com')) {
      youtubeController.close();
    }
  }

  Future<void> onRefresh() async {
    Log.d('refresh');
     getKireiTubeDetails();
  }

  Future<void> getKireiTubeDetails() async {
    hittingApi.value = true;
    kireiTubeDetailsResponse.value =
        await KireiTubeRepositories().getKireiDetailsData(videoSlug.value);
    hittingApi.value = false;
    setVideoUrl(kireiTubeDetailsResponse.value.data?.video ?? '');
    if (videoUrl.value.contains('facebook.com')) {
      initializeWebView();
    } else {
      initializeVideo(videoUrl.value);
    }
  }

  Future<void> initializeVideo(String url) async {
    try {
      final videoId = YoutubePlayerController.convertUrlToId(url);
      // Initialize the controller if not initialized
      youtubeController.value = YoutubePlayerController.fromVideoId(
        videoId: videoId!,
        autoPlay: false,
        params: const YoutubePlayerParams(
            showFullscreenButton: true, showControls: true),
      );
    } catch (e) {
      Log.d("Exception is $e");
    }
  }

  // Future<void> initializeWebView() async {
  //   webViewController = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     // Example Facebook video embed URL
  //     ..loadRequest(Uri.parse(
  //         videoUrl.value))..setJavaScriptMode(JavaScriptMode.unrestricted);
  //   print('playing facebook video');
  // }

  Future<void> initializeWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(videoUrl.value))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            // // Inject JavaScript to trigger fullscreen mode
            // webViewController?.runJavaScript('''
            //   // Find the video element
            //   var video = document.querySelector('video');
            //   if (video) {
            //     // Request fullscreen mode
            //     if (video.requestFullscreen) {
            //       video.requestFullscreen();
            //     } else if (video.mozRequestFullScreen) { // Firefox
            //       video.mozRequestFullScreen();
            //     } else if (video.webkitRequestFullscreen) { // Chrome, Safari, and Opera
            //       video.webkitRequestFullscreen();
            //     } else if (video.msRequestFullscreen) { // IE/Edge
            //       video.msRequestFullscreen();
            //     }
            //   }
            // ''');
          },
        ),
      );
  }

  @override
  void onClose() {
    youtubeController.value?.close();
    webViewController = null;
    super.onClose();
  }
}
