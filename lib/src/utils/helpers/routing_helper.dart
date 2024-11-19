import 'package:get/get.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';

class RoutingHelper {
  static urlRouting(String? url) {
    String baseUrl = AppLocalStorage().readData(LocalStorageKeys.appUrl);

    if (url != null && url.contains(baseUrl)) {
      String route = url.replaceFirst(baseUrl, '');

      try {
        switch (route) {
          case '/shop':
          case '/home':
          case '/account':
          case '/cart':
            Get.offAllNamed(route);
            break;
          case '/skincare-recommendation':
            final aiRoute = route.replaceAll('/skincare-recommendation', '');
            if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true) {
              Get.toNamed(aiRoute);
            } else {
              Get.toNamed('/login/personal-recommendation');
            }
            break;
          case '/product/':
            Get.offAllNamed(route);
            break;
          default:
            Get.toNamed(route);
        }
      } catch (e) {
        // Handle errors, e.g., log the error, display a user-friendly message, or redirect to a default screen.
        print('Error routing: $e');
        // Consider using Get.snackbar or a custom dialog to show an error message.
      }
    }
  }
}