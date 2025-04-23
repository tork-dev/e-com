import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';

class DeepLinkController extends GetxController {
  late final AppLinks _appLinks;
  late final Stream<Uri> _uriLinkStream;

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();
    _uriLinkStream = _appLinks.uriLinkStream;

    // Listen to stream for initial + future deep links
    _uriLinkStream.listen((Uri uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    print('Received Deep Link: $uri');
    Future.delayed(Duration(seconds: 1), (){
      print("urls: ${uri.path}");
    // RoutingHelper.urlRouting(uri.toString());
      if(uri.path.contains("/product")){
        Get.toNamed(uri.path);
      }
    });
  }
}
