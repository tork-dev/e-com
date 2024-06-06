import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../utils/constants/sizes.dart';

class WebViewScreen extends StatefulWidget {
  final String url, title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
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
      ..loadRequest(Uri.parse(widget.url));
    return AppLayoutWithBackButton(
      title: Text(widget.title, style: const TextStyle(color: AppColors.primary),),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        padding: AppSizes.defaultSpace,
        body: SafeArea(
            child: WebViewWidget(
      controller: controllers,
    )));
  }
}
