import 'dart:async';
import 'package:get/get.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../helper_functions.dart';
import '../routing_helper.dart';
import 'model/business_setting_response.dart';
import 'repository/business_setting_repositories.dart';

class BusinessSettingHelper {
  static Future<void> setBusinessSettingData() async {
    BusinessSettingResponse businessLists =
        await BusinessSettingRepository().getBusinessSettingList();

    // Perform local storage operations based on business settings
    for (var element in businessLists.data!) {
      switch (element.type) {
        case 'facebook_login':
          {
            bool isEnabled = element.value.toString() == "1";
            AppLocalStorage()
                .saveData(LocalStorageKeys.facebookLogin, isEnabled);
          }
          break;
        case 'google_login':
          {
            bool isEnabled = element.value.toString() == "1";
            AppLocalStorage().saveData(LocalStorageKeys.googleLogin, isEnabled);
          }
          break;
        case 'apple_login':
          {
            bool isEnabled = element.value.toString() == "1";
            AppLocalStorage().saveData(LocalStorageKeys.appleLogin, isEnabled);
          }
          break;
        case 'doctor_appointment':
          {
            bool isEnabled = element.value.toString() == "1";
            AppLocalStorage()
                .saveData(LocalStorageKeys.activeDoctorAppointment, isEnabled);
          }
          break;
        default:
          {}
          break;
      }
    }

    // Check if there are popups to display
    if (AppLocalStorage().readData(LocalStorageKeys.sowedSpinner) == true) {
      if (businessLists.popUp != null && businessLists.popUp!.isNotEmpty) {
        await showPopupsSequentially(businessLists.popUp!);
      }
    }
  }

  // Function to display popups sequentially with a delay
  static Future<void> showPopupsSequentially(List<PopUp> popups) async {
    // Filter popups for 'all' or 'app' sources
    List<PopUp> filteredPopups = popups.where((element) {
      return element.source == 'all' || element.source == 'app';
    }).toList();

    // Iterate over each filtered popup
    for (var popup in filteredPopups) {
      await Future.delayed(const Duration(seconds: 10));
      await showPopupAndWait(popup);
    }
  }

  // Function to show a single popup and wait for it to be dismissed
  static Future<void> showPopupAndWait(PopUp popup) async {
    // Completer to wait for popup to be dismissed
    Completer<void> completer = Completer<void>();

    AppHelperFunctions.showPopUpAlert(
      title: popup.title ?? '',
      subTitle: popup.description ?? '',
      leftButtonName: 'Cancel',
      rightButtonName: popup.buttonName ?? 'Ok',
      onRightPress: () {
        RoutingHelper.urlRouting(popup.route);
        completer.complete(); // Complete when "OK" is pressed
      },
      onLeftPress: () {
        Get.back();
        AppLoggerHelper.info('${AppApiEndPoints.baseUrlData}${popup.image}');
        completer.complete(); // Complete when "Cancel" is pressed
      },
      imgUrl: '${AppApiEndPoints.baseUrlData}${popup.image}',
    );

    // Wait until the completer is completed
    await completer.future;
  }
}
