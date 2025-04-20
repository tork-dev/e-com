import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/features/bottom_navigation/convex_bottom_navigation.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../utils/logging/logger.dart';
import '../order_status_page.dart';

class BkashScreen extends StatefulWidget {
  final double amount;
  final String paymentType;
  final String paymentMethodKey;
  final String bkashInitialUrl;
  final int orderId;

  const BkashScreen({
    super.key,
    this.amount = 0.00,
    this.paymentType = "",
    this.paymentMethodKey = "",
    required this.orderId,
    required this.bkashInitialUrl,
  });

  @override
  _BkashScreenState createState() => _BkashScreenState();
}

class _BkashScreenState extends State<BkashScreen> {
  int combinedOrderId = 0;
  bool orderInit = false;
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    if (widget.bkashInitialUrl != null) {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              readResponse();
            },
            onWebResourceError: (error) {
              Log.d(error.toString());
              navigateToOrderSuccess("Something went wrong.", false);
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.bkashInitialUrl));
    }
  }

  @override
  Widget build(BuildContext context) {

    return AppLayoutWithBackButton(
        showCustomLeading: true,
        backToHome: true,
        showBackButton: false,
        customLeadingIcon: Icons.arrow_back,
      title: const Text('Pay with Bkash', style: TextStyle(color: AppColors.primary),),
        leadingOnPress: (){
          Log.d('working');
        Get.offAll(()=> const HelloConvexAppBar());
        },
        padding: 0,
        body: buildBody());
  }

  Widget buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: WebViewWidget(controller: webViewController),
    );
  }



  void readResponse() async {
    webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      var decodedJSON = jsonDecode(data.toString());
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);

      Log.d('Bkash json Response: $decodedJSON');

      if (responseJSON["result"] == true) {
        // handle success
        navigateToOrderSuccess("Order Successful", true);
      } else if (responseJSON["result"] == false) {
        // handle failure
        navigateToOrderSuccess("Payment Cancelled", false);
      }
    });
  }

  void navigateToOrderSuccess(String message, bool status) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => AppOrderStatusScreen(
          orderId: widget.orderId,
          statusString: message,
          status: status,
        ),
      ),
          (route) => false,
    );
  }

}
