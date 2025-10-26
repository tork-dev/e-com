import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';
import '../logging/logger.dart';

class RoutingHelper {
  static void urlRouting(String? url) {
    String baseUrl = AppLocalStorage().readData(LocalStorageKeys.appUrl);
    debugPrint("url to route $url");
    Log.d(baseUrl);
    if (url != null) {
      if (url.contains(baseUrl)) {
        String route = url.replaceFirst(baseUrl, '/');
        if ((route.startsWith('/account') ||
                route.startsWith('/wishlist') ||
                route.startsWith("/account-details") ||
                route.startsWith("/orders-details") ||
                route.startsWith("/orders") ||
                route.startsWith("/order") ||
                route.startsWith("/reward") ||
                route.startsWith("/point-history")) &&
            AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null) {
          Get.toNamed('/login', arguments: {"prevRoute": route});
          return;
        }

        if (route.startsWith('/shop') ||
            route.startsWith('/home') ||
            route.startsWith('/account') ||
            route.startsWith('/cart')) {
          Get.offAllNamed(route);
        } else if (route.endsWith('/skincare-recommendation')) {
          final aiRoute = route.replaceAll('/skincare-recommendation', '');
          if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true) {
            Get.toNamed(aiRoute);
          } else {
            Get.toNamed(
              '/login',
              arguments: {"prevRoute": '/personal-recommendation'},
            );
          }
        } else if (route.startsWith('/product')) {
          Get.offNamed(route);
        } else {
          debugPrint("route $route");
          Get.toNamed(route);
        }
      }
    }
  }
}
