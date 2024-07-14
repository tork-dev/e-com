import 'package:get/get.dart';
import 'package:kirei/src/features/de_active_account/repositories/de_active_repositories.dart';
import 'package:kirei/src/features/de_active_account/view/widgets/de_active_widgets.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../model/de_active_model.dart';

class DeActiveController extends GetxController{
  static DeActiveController get instance => Get.find();


  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;
  Rx<DeActiveAccountResponse> deActiveResponse = DeActiveAccountResponse().obs;



  Future<void> deActiveAccount() async {

      isLoading.value = true;

    try {
      deActiveResponse.value = await DeActiveRepo().deActiveUserAccount();
        isLoading.value = false;

      DeActiveWidgets().buildFinalStatusMessage(
          status: deActiveResponse.value.success == true ? 'User has deactivated.' : 'Failed to deactivate account.');
    } catch (error) {
        isLoading.value = false;
      AppHelperFunctions.showToast('Error: $error');
    }
  }
}