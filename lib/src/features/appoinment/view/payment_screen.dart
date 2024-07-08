import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppointmentPaymentScreen extends StatefulWidget {
  final String bkashInitialUrl;

  const AppointmentPaymentScreen({
    super.key,
    required this.bkashInitialUrl,
  });

  @override
  _AppointmentPaymentScreenState createState() => _AppointmentPaymentScreenState();
}

class _AppointmentPaymentScreenState extends State<AppointmentPaymentScreen> {
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
              print(error);
              AppHelperFunctions.showToast('Something went wrong');
              Get.offAll(const HelloConvexAppBar(pageIndex: 0,));
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.bkashInitialUrl));
    }
  }

  @override
  Widget build(BuildContext context) {

    return AppLayoutWithBackButton(
        title: const Text('Pay with Bkash', style: TextStyle(color: AppColors.primary),),
        leadingOnPress: (){
          print('working');
          Get.offAll(()=> const HelloConvexAppBar(pageIndex: 0,));
        },
        padding: AppSizes.defaultSpace,
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
    var paymentDetails = '';
    webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      var decodedJSON = jsonDecode(data.toString());
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);

      print('Bkash json Response: $decodedJSON');

      if (responseJSON["result"] == true) {
        AppHelperFunctions.showToast('Payment Successful');
        // handle success
        Get.offAll(const HelloConvexAppBar(pageIndex: 0,));
      } else if (responseJSON["result"] == false) {
        AppHelperFunctions.showToast('Payment cancelled');
        // handle failure
        Get.offAll(const HelloConvexAppBar(pageIndex: 0,));
      }
    });
  }

  void navigateToOrderSuccess() {

    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => AppOrderStatusScreen(
    //       orderId: widget.orderId,
    //       statusString: message,
    //       status: status,
    //     ),
    //   ),
    //       (route) => false,
    // );
  }

}
