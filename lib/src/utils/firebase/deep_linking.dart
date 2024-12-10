import 'package:app_links/app_links.dart';

class DeepLinking{
  final appLinks = AppLinks(); // AppLinks is singleton


  void deepLink() {
    final sub = appLinks.uriLinkStream.listen((uri) {
      print(uri);
    });
  }
}