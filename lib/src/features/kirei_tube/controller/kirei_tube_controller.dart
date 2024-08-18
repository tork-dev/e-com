import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_response_model.dart';
import 'package:kirei/src/features/kirei_tube/repositories/kirei_tube_repositories.dart';
import 'package:kirei/src/utils/logging/logger.dart';

class KireiTubeController extends GetxController{
  static KireiTubeController get instance => Get.find();

  RxBool hittingApi = false.obs;
  Rx<KireiTubeResponse> videoList = KireiTubeResponse().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVideoList();
  }

  Future<void> onRefresh() async{
    AppLoggerHelper.debug('refresh');
  }


  Future<void> getVideoList() async{
    hittingApi.value = true;
    videoList.value = await KireiTubeRepositories().getKireiTubeList();
    hittingApi.value = false;

  }
}