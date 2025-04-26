import 'dart:async';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:kirei/src/features/bottom_navigation/convex_bottom_navigation.dart';
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

  Future<void> appInfo() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    AppLocalStorage().saveData(LocalStorageKeys.appVersion, version);
  }



  changeScreen() {
    final bool isNotFirst =
        AppLocalStorage().readData(LocalStorageKeys.isNotFirstTime) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      isNotFirst == true ?
      Get.offAll(() =>  const HelloConvexAppBar())
          : Get.offAll(() => const OnBoarding());
    });
  }
}
