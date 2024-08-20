// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:share_plus/share_plus.dart';
//
// class DynamicLinkProvider {
//   Future<Uri> createDynamicLink(bool short) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://kireibd.page.link',
//       link: Uri.parse('https://kireibd.com/kirei'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.thetork.kirei',
//         minimumVersion: 0,
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'com.thetork.kirei',
//         minimumVersion: '0',
//       ),
//     );
//
//     Uri url;
//     if (short) {
//       final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//       url = shortLink.shortUrl;
//     } else {
//       url = await FirebaseDynamicLinks.instance.buildLink(parameters);
//     }
//
//     return url;
//   }
//
//   void initDynamicLink() async{
//     final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
//     if(instanceLink != null){
//       final Uri refLink = instanceLink.link;
//       Share.share("this ");
//     }
//   }
// }
