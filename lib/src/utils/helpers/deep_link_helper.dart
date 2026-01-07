import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';

import '../logging/logger.dart';

class DeepLinkController extends GetxController {
  late final AppLinks _appLinks;
  late final StreamSubscription<Uri> _uriLinkSubscription;

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();
    _initDeepLinkHandling();
  }

  void _initDeepLinkHandling() async {
    try {
      // Handle initial deep link when app is launched from a terminated state
      final Uri? initialLink = await _appLinks.getInitialLink();
      debugPrint("initial url $initialLink");
      if (initialLink != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 500), () {
            handleDeepLink(initialLink);
          });
        });
      }

      // Listen for future deep link events while app is running
      _uriLinkSubscription = _appLinks.uriLinkStream.listen(
        (Uri uri) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(milliseconds: 500), () {
              handleDeepLink(uri);
            });
          });
        },
        onError: (err) {
          Log.e("Deep link stream error: $err");
        },
      );
    } catch (e) {
      debugPrint("Deep link setup error: $e");
    }
  }

  void handleDeepLink(Uri uri) {
    try {
      debugPrint("Handling Deep Link: $uri");
      String path = uri.path;
      if (path.isEmpty || path == '/') {
        debugPrint("Deep link points to root, allowing default navigation.");
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RoutingHelper.urlRouting(uri.toString());
      });
    } catch (e) {
      debugPrint("Error handling deep link: $e");
    }
  }

  @override
  void onClose() {
    _uriLinkSubscription.cancel();
    super.onClose();
  }
}
