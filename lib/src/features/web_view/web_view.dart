import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../utils/constants/sizes.dart';

class WebViewScreen extends StatefulWidget {
  final String url, title;
  final double? bodyPadding;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.title,
    this.bodyPadding,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;


  @override
  Widget build(BuildContext context) {

    WebViewController controllers =
    WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
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
      title: Text(
        widget.title,
        style: const TextStyle(color: AppColors.secondary),
      ),
      bodyBackgroundColor: AppColors.white,
      centerTitle: true,
      leadingIconColor: AppColors.darkGrey,
      padding:
      widget.bodyPadding != null
          ? widget.bodyPadding!
          : AppSizes.md,
      body: SafeArea(child: WebViewWidget(controller: controllers)),
    );
  }
}
