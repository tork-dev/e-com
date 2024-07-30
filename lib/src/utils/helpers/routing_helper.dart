import 'package:get/get.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';

class RoutingHelper{

  static urlRouting(String url) {
      const String baseUrl = 'https://beta.kireibd.com';
    if (url.contains(baseUrl)) {
      String route = url.replaceFirst(baseUrl, '');

      if (route == '/personal-recommendation/skincare-recommendation' &&
          AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != true) {
        Get.toNamed('/login');
        return;
      }
      if(route.contains('/shop') || route.contains('/home') || route.contains('/account') || route.contains('/cart')){
      Get.offAllNamed(route);
      }else if(route == '/personal-recommendation/skincare-recommendation') {
        Get.toNamed(route.replaceAll('/skincare-recommendation', ''));
      }else{
        Get.toNamed(route);
      }
    }else{
      Get.offAllNamed('/home');
    }
  }
}