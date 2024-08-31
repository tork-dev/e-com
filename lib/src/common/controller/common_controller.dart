import 'package:get/get.dart';

import '../../utils/helpers/business_setting/business_setting_helper.dart';
import '../../utils/helpers/gigalogy/controller/gigalogy_controller.dart';
import '../../utils/local_storage/local_storage_keys.dart';
import '../../utils/local_storage/storage_utility.dart';

class CommonController extends GetxController{
  static CommonController get instance => Get.find();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    BusinessSettingHelper.setBusinessSettingData();
    if(AppLocalStorage().readData(LocalStorageKeys.gaipUserId) == null){
      Get.put(GaipUserIdController());
    }
  }


  // Future<void>


}