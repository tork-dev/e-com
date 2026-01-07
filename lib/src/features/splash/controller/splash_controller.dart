import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../on_boarding/views/on_boarding.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  RxBool spinnerActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    appInfo();
    changeScreen();
  }

  Future<void> appInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    AppLocalStorage().saveData(LocalStorageKeys.appVersion, version);
  }

  void changeScreen() {
    final bool isNotFirst =
        AppLocalStorage().readData(LocalStorageKeys.isNotFirstTime) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      // If we have already navigated away from Splash (e.g. by a deep link), do nothing.
      if (Get.currentRoute != '/') {
        debugPrint(
          "Already navigated to ${Get.currentRoute}, skipping splash transition.",
        );
        return;
      }
      isNotFirst == true
          ? Get.offAllNamed("/home")
          : Get.offAll(() => const OnBoarding());
    });
  }
}
