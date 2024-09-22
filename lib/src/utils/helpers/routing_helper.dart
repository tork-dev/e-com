import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';

class RoutingHelper {

  static urlRouting(String? url) {
    const String baseUrl = "https://kireibd.com";
    if (url != null) {
      if (url.contains(baseUrl)) {
        String route = url.replaceFirst(baseUrl, '');

        // if (route == '/personal-recommendation/skincare-recommendation' &&
        //     AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != true) {
        //   Get.toNamed('/login');
        //   return;
        // }
        if (route.startsWith('/shop') || route.startsWith('/home') ||
            route.startsWith('/account') || route.startsWith('/cart')) {
          Get.offAllNamed(route);
        } else if (route.endsWith('/skincare-recommendation')) {
          final aiRoute = route.replaceAll('/skincare-recommendation', '');
          if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true) {
            Get.toNamed(aiRoute);
          } else {
            Get.toNamed('/login/personal-recommendation');
          }
        } else {
          Get.toNamed(route);
        }
      } else {
        Get.offAllNamed('/home');
      }
    } else {
      Get.offAllNamed('/home');
    }
  }
}