import 'package:get/get.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';

class RoutingHelper{

  static urlRouting(String url) {
      const String baseUrl = 'https://beta.kireibd.com';
    if (url.contains(baseUrl)) {
      String route = url.replaceFirst(baseUrl, '') +
          url.replaceAll('/skincare-recommendation', '');

      if (route == '/personal-recommendation/skincare-recommendation' &&
          AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != true) {
        Get.toNamed('/login');
        return;
      }
      Get.toNamed(route);
    }else{
      Get.offAllNamed('/home');
    }
  }
}