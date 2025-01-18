import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_details_model.dart';
import 'package:kirei/src/features/kirei_tube/repositories/kirei_tube_repositories.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class KireiTubeDetailsController extends GetxController {
  static KireiTubeDetailsController get instance => Get.find();

  RxBool hittingApi = false.obs;
  Rx<KireiTubeDetailsResponse> kireiTubeDetailsResponse =
      KireiTubeDetailsResponse().obs;
  Rx<YoutubePlayerController?> youtubeController =
      Rx<YoutubePlayerController?>(null);
  RxString videoSlug = ''.obs;
  final videoUrl = ''.obs;
  WebViewController? webViewController;

  void setVideoUrl(String url) {
    videoUrl.value = url;
  }

  @override
  void onInit() {
    super.onInit();
    videoSlug.value = Get.parameters['id']!;
    if (videoSlug.isNotEmpty) {
      onRefresh();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (!videoUrl.value.contains('facebook.com')) {
      youtubeController.close();
    }
  }

  Future<void> onRefresh() async {
    print('refresh');
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
      print("Exception is $e");
    }
  }

  Future<void> initializeWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // Example Facebook video embed URL
      ..loadRequest(Uri.parse(
          videoUrl.value))..setJavaScriptMode(JavaScriptMode.unrestricted);
    print('playing facebook video');
  }

  @override
  void onClose() {
    youtubeController.value?.close();
    webViewController = null;
    super.onClose();
  }
}
