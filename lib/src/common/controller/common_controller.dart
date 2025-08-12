import 'package:get/get.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../utils/helpers/business_setting/business_setting_helper.dart';
import '../../utils/helpers/gigalogy/controller/gigalogy_controller.dart';

class CommonController extends GetxController {
  static CommonController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();

    AppLocalStorage().saveData(LocalStorageKeys.facebookLogin, false);
    AppLocalStorage().saveData(LocalStorageKeys.googleLogin, false);
    AppLocalStorage().saveData(LocalStorageKeys.appleLogin, false);
    AppLocalStorage().saveData(LocalStorageKeys.facebookLogin, false);
    AppLocalStorage().saveData(LocalStorageKeys.facebookLogin, false);

    showPopUp();
  }

  // Method to handle popup display
  Future<void> showPopUp() async {
    Log.d("show pop up called");
    await BusinessSettingHelper().setBusinessSettingData();
  }
}
