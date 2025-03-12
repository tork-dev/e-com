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

    // Initialize GAIP User ID Controller if not already initialized
      Log.d('calling gaip user id before');
    if (AppLocalStorage().readData(LocalStorageKeys.gaipUserId) == null) {
      Log.d('calling gaip user id');
      GaipUserIdController().getGaipUserId();
    }
    showPopUp();
  }

  // Method to handle popup display
  Future<void> showPopUp() async {
    Log.d("show pop up called");
    await BusinessSettingHelper().setBusinessSettingData();
  }
}
