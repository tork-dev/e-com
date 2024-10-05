
import 'package:get/get.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';

class RoutingHelper {

  static urlRouting(String? url) {
    String baseUrl = AppLocalStorage().readData(LocalStorageKeys.appUrl);
    print(baseUrl);
    if (url != null) {
      if (url.contains(baseUrl)) {
        String route = url.replaceFirst(baseUrl, '');
        // String route = '/product/skin-aqua-super-moisture-gel-spf50-pa-110g1';
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