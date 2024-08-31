import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_details_model.dart';
import 'package:kirei/src/features/kirei_tube/repositories/kirei_tube_repositories.dart';


class KireiTubeDetailsController extends GetxController{
  static KireiTubeDetailsController get instance => Get.find();


  RxBool hittingApi = false.obs;
  Rx<KireiTubeDetailsResponse> kireiTubeDetailsResponse = KireiTubeDetailsResponse().obs;
  RxString videoSlug = ''.obs;



  @override
  void onInit() {
    super.onInit();
    videoSlug.value = Get.parameters['id']!;
 // getKireiTubeData(videoSlug.value);

  }


  @override
  void dispose() {
    super.dispose();
   // flickManager.value?.dispose();
  }

  Future<void> onRefresh() async{
    print('refresh');
  }


  // Future<void> getKireiTubeData(String videoSlug) async{
  //   hittingApi.value = true;
  //   kireiTubeDetailsResponse.value = await KireiTubeRepositories().getKireiDetailsData(videoSlug);
  //   flickManager.value = FlickManager(
  //     videoPlayerController:
  //     VideoPlayerController.networkUrl(Uri.parse(kireiTubeDetailsResponse.value.data!.video!),
  //     ),
  //     autoPlay: false,
  //   );
  //
  //   String videoId;
  //   videoId = YoutubePlayer.convertUrlToId(kireiTubeDetailsResponse.value.data!.video!)!;
  //   youtubeVideo.value = YoutubePlayerController(
  //     initialVideoId: "aiEMFokemo",
  //     flags: const YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: true,
  //     ),
  //   );
  //
  //   hittingApi.value = false;
  // }

}