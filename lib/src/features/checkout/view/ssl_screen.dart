import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../bottom_navigation/convex-bottom_navigation.dart';
import 'order_status_page.dart';


class SslCommerzScreen extends StatefulWidget {
  final int amount;
  final String paymentType;
  final String paymentMethodKey;
  final String sslInitialUrl;
  final int orderId;

  const SslCommerzScreen({
    Key? key,
    this.amount = 0,
    this.paymentType = "",
    this.paymentMethodKey = "",
    required this.orderId,
    required this.sslInitialUrl,
  }) : super(key: key);

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
              navigateToOrderSuccess('Order Successful', "success");
            } else if (url.contains("status=failure") || url.contains("status=DECLINED")) {
              AppHelperFunctions.showToast("Payment Cancelled");
              navigateToOrderSuccess("Payment Cancelled", "danger");
            }
          },
          onWebResourceError: (error) {
            print(error);
            navigateToOrderSuccess("Something went wrong.", "danger");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.sslInitialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return AppLayoutWithBackButton(
        padding: AppSizes.defaultSpace,
        title: const Text('Pay with Sslcommerz', style: TextStyle(color: AppColors.primary),),
        leadingOnPress: (){
          print('working');
          Get.offAll(()=> const HelloConvexAppBar());
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


  void navigateToOrderSuccess(String message, String type) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => AppOrderStatusScreen(
          statusString: '',
          orderId: widget.orderId,
        ),
      ),
          (route) => false,
    );
  }
}
