import 'package:get/get.dart';
import 'package:kirei/src/features/spinner_wheel/controller/spinner_controller.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../utils/helpers/business_setting/business_setting_helper.dart';
import '../../utils/helpers/gigalogy/controller/gigalogy_controller.dart';
import '../../utils/helpers/helper_functions.dart';

class CommonController extends GetxController {
  static CommonController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();

    // Initialize GAIP User ID Controller if not already initialized
    if (AppLocalStorage().readData(LocalStorageKeys.gaipUserId) == null) {
      Get.put(GaipUserIdController());
    }
    showPopUp();
  }

  // Method to handle popup display
  Future<void> showPopUp() async {
    await BusinessSettingHelper().setBusinessSettingData();
  }
}
