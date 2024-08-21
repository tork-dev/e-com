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
  getKireiTubeData(videoSlug.value);

  }

  Future<void> onRefresh() async{
    print('refresh');
  }


  Future<void> getKireiTubeData(String videoSlug) async{
    hittingApi.value = true;
    kireiTubeDetailsResponse.value = await KireiTubeRepositories().getKireiDetailsData(videoSlug);
    hittingApi.value = false;
  }

}