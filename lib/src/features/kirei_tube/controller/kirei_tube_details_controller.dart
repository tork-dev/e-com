import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_details_model.dart';
import 'package:kirei/src/features/kirei_tube/repositories/kirei_tube_repositories.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class KireiTubeDetailsController extends GetxController{
  static KireiTubeDetailsController get instance => Get.find();


  RxBool hittingApi = false.obs;
  Rx<KireiTubeDetailsResponse> kireiTubeDetailsResponse = KireiTubeDetailsResponse().obs;
  Rx<FlickManager?> flickManager = Rx<FlickManager?>(null);
  RxString videoSlug = ''.obs;



  @override
  void onInit() {
    super.onInit();
    videoSlug.value = Get.parameters['id']!;
    onRefresh();

  }


  @override
  void dispose() {
    super.dispose();
   // flickManager.value?.dispose();
  }

  Future<void> onRefresh() async{
    print('refresh');
    getKireiTubeDetails();
  }

  Future<void> getKireiTubeDetails()async{
    hittingApi.value = true;
    kireiTubeDetailsResponse.value = await KireiTubeRepositories().getKireiDetailsData(videoSlug.value);
    hittingApi.value = false;
    initializeVideo(kireiTubeDetailsResponse.value.data?.video ?? '');
  }

  Future<void> initializeVideo(String url) async {
    final yt = YoutubeExplode();

    // Extract video ID from the URL
    var videoId = VideoId.fromString(url);

    var streamInfo = await yt.videos.streamsClient.getManifest(videoId);
    var streamUrl = streamInfo.muxed.bestQuality;

    flickManager.value = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(streamUrl.url),
    );
    yt.close(); // Close the YoutubeExplode instance
  }


  @override
  void onClose() {
    flickManager.value?.dispose();
    super.onClose();
  }
}


