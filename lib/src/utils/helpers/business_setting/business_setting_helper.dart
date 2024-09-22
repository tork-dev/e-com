import 'dart:async';
import 'package:get/get.dart';
import 'package:kirei/src/features/spinner_wheel/controller/spinner_controller.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../helper_functions.dart';
import '../routing_helper.dart';
import 'model/business_setting_response.dart';
import 'repository/business_setting_repositories.dart';

class BusinessSettingHelper extends GetxController{
  RxInt intervalTime = 0.obs;
  RxBool isSpinnerActive = false.obs;
   Future<void> setBusinessSettingData() async {


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
        case 'spinner_status':
          {
            bool isEnabled = element.value.toString() == "1";
            isSpinnerActive.value = isEnabled;
            print('value: $isEnabled');
          }
          break;
        default:
          {}
          break;
      }
    }

    if (AppLocalStorage().readData(LocalStorageKeys.sowedSpinner) == null && isSpinnerActive.value){
      Future.delayed(const Duration(seconds: 10),
              () => AppHelperFunctions().showAlertForFirstTime());
      return;
    }


    // Check if there are popups to display
    if (AppLocalStorage().readData(LocalStorageKeys.sowedSpinner) == true) {
      if (businessLists.popup?.data != null && businessLists.popup!.data!.isNotEmpty) {
        intervalTime.value = businessLists.popup?.interval ?? 0;
        await showPopupsSequentially(businessLists.popup!.data!);
      }
    }
  }

  // Function to display popups sequentially with a delay
   Future<void> showPopupsSequentially(List<PopupDatum> popups) async {
    // Filter popups for 'all' or 'app' sources
    List<PopupDatum> filteredPopups = popups.where((element) {
      return element.source == 'all' || element.source == 'app';
    }).toList();

    // Iterate over each filtered popup
    for (var popup in filteredPopups) {
      await Future.delayed( Duration(seconds: intervalTime.value));
      await showPopupAndWait(popup);
    }
  }

  // Function to show a single popup and wait for it to be dismissed
  static Future<void> showPopupAndWait(PopupDatum popup) async {
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
      imgUrl: popup.image,
    );

    // Wait until the completer is completed
    await completer.future;
  }
}
