import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';


class FacebookWebViewPlayer extends StatefulWidget {
  final String url;

  const FacebookWebViewPlayer({super.key, required this.url});

  @override
  State<FacebookWebViewPlayer> createState() => _FacebookWebViewPlayerState();
}

class _FacebookWebViewPlayerState extends State<FacebookWebViewPlayer> {
  @override
  Widget build(BuildContext context) {
    WebViewController controllers = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.youtube.com/watch?v=C9mBdibFZvQ'));
    return  WebViewWidget(
              controller: controllers,
            );
  }
}
