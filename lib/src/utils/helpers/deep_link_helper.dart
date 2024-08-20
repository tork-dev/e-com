// import 'dart:async';
// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kirei/src/utils/helpers/routing_helper.dart';
//
// class DeepLinkHelper {
//   final AppLinks _appLinks = AppLinks();
//   StreamSubscription<Uri>? _linkSubscription;
//
//   void deepLinkController() {
//     print('initial deep link');
//     _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
//       if (uri != null) {
//         print('Received deep link: $uri');
//         // handleDeepLink(uri);
//         RoutingHelper.urlRouting(uri.toString());
//       }
//     }, onError: (Object err) {
//       print('Failed to receive deep link: $err');
//     });
//   }
//
//   void handleDeepLink(Uri uri) {
//     // Example: handle deep link and navigate to the correct page
//     if (uri.path == '/book/hello-world') {
//       Get.toNamed('/register');
//     } else {
//       print('Unknown deep link: $uri');
//     }
//   }
//
//   void dispose() {
//     _linkSubscription?.cancel();
//   }
// }
