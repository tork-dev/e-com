import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../bottom_navigation/convex-bottom_navigation.dart';
import '../order_status_page.dart';

class SslCommerzScreen extends StatefulWidget {
  final double amount;
  final String paymentType;
  final String paymentMethodKey;
  final String sslInitialUrl;
  final int orderId;

  const SslCommerzScreen({
    super.key,
    this.amount = 0,
    this.paymentType = "",
    this.paymentMethodKey = "",
    required this.orderId,
    required this.sslInitialUrl,
  });

  @override
   _SslCommerzScreenState createState() => _SslCommerzScreenState();
}

class _SslCommerzScreenState extends State<SslCommerzScreen> {
  int combinedOrderId = 0;
  bool orderInit = false;
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            print(url);
            if (url.contains("status=success")) {
              AppHelperFunctions.showToast('Order Successful');
              navigateToOrderSuccess('Order Successful', true);
            } else if (url.contains("status=failure") ||
                url.contains("status=DECLINED")) {
              AppHelperFunctions.showToast("Payment Cancelled");
              navigateToOrderSuccess("Payment Cancelled", false);
            }
          },
          onWebResourceError: (error) {
            print(error);
            navigateToOrderSuccess("Something went wrong.", false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.sslInitialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return AppLayoutWithBackButton(
        padding: AppSizes.defaultSpace,
        title: const Text(
          'Pay with Sslcommerz',
          style: TextStyle(color: AppColors.primary),
        ),
        leadingOnPress: () {
          print('working');
          Get.offAll(() => const HelloConvexAppBar());
        },
        body: buildBody());
  }

  Widget buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: WebViewWidget(controller: webViewController),
    );
  }

  void navigateToOrderSuccess(String message, bool status) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => AppOrderStatusScreen(
          statusString: message,
          status: status,
          orderId: widget.orderId,
        ),
      ),
      (route) => false,
    );
  }
}
