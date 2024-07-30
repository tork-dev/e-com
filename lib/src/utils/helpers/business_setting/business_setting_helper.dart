import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import 'model/business_setting_response.dart';
import 'repository/business_setting_repositories.dart';

class BusinessSettingHelper {

  static setBusinessSettingData() async {
    BusinessSettingResponse businessLists =
    await BusinessSettingRepository().getBusinessSettingList();

    for (var element in businessLists.data!) {
      switch (element.type) {
        case 'facebook_login':
          {
            if (element.value.toString() == "1") {
              AppLocalStorage().saveData(LocalStorageKeys.facebookLogin, true);
            } else {
              AppLocalStorage().saveData(LocalStorageKeys.facebookLogin, false);
            }
          }
          break;
        case 'google_login':
          {
            if (element.value.toString() == "1") {
              AppLocalStorage().saveData(LocalStorageKeys.googleLogin, true);
            } else {
              AppLocalStorage().saveData(LocalStorageKeys.googleLogin, false);
            }
          }
          break;
        case 'apple_login':
          {
            if (element.value.toString() == "1") {
              AppLocalStorage().saveData(LocalStorageKeys.appleLogin, true);
            } else {
              AppLocalStorage().saveData(LocalStorageKeys.appleLogin, false);
            }
          }
          break;
        case 'doctor_appointment':
          {
            if (element.value.toString() == "1") {
              AppLocalStorage().saveData(LocalStorageKeys.activeDoctorAppointment, true);
            } else {
              AppLocalStorage().saveData(LocalStorageKeys.activeDoctorAppointment, false);
            }
          }
          break;
        default:
          {}
          break;
      }
    }
  }
}