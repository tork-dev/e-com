import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_details_model.dart';
import 'package:kirei/src/features/kirei_tube/repositories/kirei_tube_repositories.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class KireiTubeDetailsController extends GetxController{
  static KireiTubeDetailsController get instance => Get.find();


  RxBool hittingApi = false.obs;
  Rx<KireiTubeDetailsResponse> kireiTubeDetailsResponse = KireiTubeDetailsResponse().obs;
  Rx<YoutubePlayerController?> youtubeController = Rx<YoutubePlayerController?>(null);
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
    youtubeController.close();
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
    try{
    final videoId = YoutubePlayerController.convertUrlToId(url);
    // Initialize the controller if not initialized
    youtubeController.value = YoutubePlayerController.fromVideoId(
      videoId: videoId!,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true, showControls: true),
    );
  }catch(e){
      print("Exception is $e");
    }
    }


  @override
  void onClose() {
    youtubeController.value?.close();
    super.onClose();
  }
}


