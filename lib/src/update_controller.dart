import 'dart:io'; // To detect the platform
import 'package:upgrader/upgrader.dart';

class CustomUpgraderStoreController extends UpgraderStoreController {
  Future<String?> get appStoreUrl async {
    if (Platform.isAndroid) {
      // Google Play Store URL (replace with your app's package name)
      return 'https://play.google.com/store/apps/details?id=com.thetork.kirei&hl=en';
    } else if (Platform.isIOS) {
      // Apple App Store URL (replace with your app's ID)
      return 'https://apps.apple.com/hu/app/kirei/id6502335026';
    } else {
      return null; // Other platforms can be handled here if necessary
    }
  }
}
