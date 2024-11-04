import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/features/on_boarding/controllers/on_boarding_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../../../features/spinner_wheel/controller/spinner_controller.dart';
import '../../constants/sizes.dart';
import '../../device/device_utility.dart';
import '../helper_functions.dart';
import '../routing_helper.dart';
import 'model/business_setting_response.dart';
import 'repository/business_setting_repositories.dart';

class BusinessSettingHelper extends GetxController {
  RxInt intervalTime = 0.obs;
  RxBool isSpinnerActive = false.obs;
  RxString androidAppVersion = ''.obs;
  RxString iosAppVersion = ''.obs;
  RxBool isAndroidUpdateRequired = false.obs;
  RxBool isIosUpdateRequired = false.obs;

  Future<void> setBusinessSettingData() async {
    OnBoardingController onBoardingController = OnBoardingController.instance;

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
          }
          break;
        case 'android_app_version':
          {
            androidAppVersion.value = element.value.toString();
          }
          break;
        case 'ios_app_version':
          {
            iosAppVersion.value = element.value.toString();
          }
          break;
        case 'required_android_update':
          {
            isAndroidUpdateRequired.value = element.value.toString() == "1";
          }
          break;
        case 'required_ios_update':
          {
            isIosUpdateRequired.value = element.value.toString() == "1";
          }
          break;
        default:
          {}
          break;
      }
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    bool updateAvailable = AppHelperFunctions().isVersionLessThan(version,
        Platform.isAndroid ? androidAppVersion.value : iosAppVersion.value);
    bool updateRequired = Platform.isAndroid
        ? isAndroidUpdateRequired.value
        : isIosUpdateRequired.value;

    debugPrint(
        'update required ${AppHelperFunctions().isVersionLessThan(version, Platform.isAndroid ? androidAppVersion.value : iosAppVersion.value)}');
    debugPrint('Device OS ${Platform.operatingSystem}');
    debugPrint('Device android version ${Platform.operatingSystemVersion}');

    if (updateAvailable) {
      Future.delayed(
          const Duration(seconds: 10),
          () => showDialog(
              barrierDismissible: !updateRequired,
              context: Get.overlayContext!,
              builder: (context) {
                return Stack(
                  children: [
                    Dialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: PopScope(
                        canPop: !updateRequired,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(AppSizes.defaultSpace),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.update),
                                  const Gap(AppSizes.md),
                                  Text(
                                    'Update Available',
                                    style:
                                        Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const Gap(AppSizes.md),
                                  Text(
                                    'New version is available. Please update your app.',
                                    style: Theme.of(context).textTheme.titleLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(AppSizes.md),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: AppButtons.largeFlatFilledButton(
                                            backgroundColor:
                                                AppColors.addToCartButton,
                                            onPressed: () {
                                              AppDeviceUtils.browseUrl(Platform
                                                      .isAndroid
                                                  ? 'https://play.google.com/store/apps/details?id=com.thetork.kirei&hl=en&gl=US'
                                                  : 'https://apps.apple.com/us/app/kirei/id6502335026?platform=iphone');
                                            },
                                            buttonText: 'Update'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: !updateRequired,
                              child: Positioned(
                                right: AppSizes.md,
                                top: AppSizes.md,
                                child: AppCardContainer(
                                    onTap: ()=> Get.back(),
                                    applyRadius: false,
                                    backgroundColor: AppColors.grey,
                                    height: 40,
                                    width: 40,
                                    child: const Icon(Icons.clear)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }));
      return;
    }

    if (AppLocalStorage().readData(LocalStorageKeys.sowedSpinner) == null &&
        isSpinnerActive.value &&
        onBoardingController.spinnerActive.value) {
      Get.put(SpinnerController());
      Future.delayed(const Duration(seconds: 10),
          () => AppHelperFunctions().showAlertForFirstTime());
      return;
    }

    // Check if there are popups to display
    if (AppLocalStorage().readData(LocalStorageKeys.sowedSpinner) == true) {
      print('interval time $intervalTime');
      if (businessLists.popup?.data != null &&
          businessLists.popup!.data!.isNotEmpty) {
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
      await Future.delayed(Duration(seconds: intervalTime.value));
      await showPopupAndWait(popup);
    }
  }

  // Function to show a single popup and wait for it to be dismissed
  static Future<void> showPopupAndWait(PopupDatum popup) async {
    // Completer to wait for popup to be dismissed
    Completer<void> completer = Completer<void>();

    AppHelperFunctions.showPopUpAlert(
      title: popup.title,
      subTitle: popup.description,
      leftButtonName: 'Cancel',
      rightButtonName: popup.buttonName,
      onRightPress: () {
        RoutingHelper.urlRouting(popup.route);
        completer.complete(); // Complete when "OK" is pressed
      },
      onLeftPress: () {
        Get.back();
        completer.complete(); // Complete when "Cancel" is pressed
      },
      imgUrl: popup.image,
    );

    // Wait until the completer is completed
    await completer.future;
  }
}
