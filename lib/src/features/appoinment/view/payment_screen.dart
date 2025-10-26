import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/logging/logger.dart';

class AppointmentPaymentScreen extends StatefulWidget {
  final String initialUrl;
  final String screenName;


  const AppointmentPaymentScreen({
    super.key,
    required this.initialUrl,
    required this.screenName
  });

  @override
  _AppointmentPaymentScreenState createState() =>
      _AppointmentPaymentScreenState();
}

class _AppointmentPaymentScreenState extends State<AppointmentPaymentScreen> {
  int combinedOrderId = 0;
  bool orderInit = false;
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            readResponse();
          },
          onWebResourceError: (error) {
            Log.d(error.toString());
            AppHelperFunctions.showToast('Something went wrong');
            Get.offAllNamed("/home");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return AppLayoutWithBackButton(
      backToHome: true,
        title: Text('Pay with ${widget.screenName}',
          style: const TextStyle(color: AppColors.primary),),
        showBackButton: false,
        customLeadingIcon: Icons.arrow_back_ios_new_rounded,
        showCustomLeading: true,
        leadingOnPress: () {
          Log.d('working');
          Get.offAllNamed("/home");
        },
        padding: AppSizes.defaultSpace,
        body: buildBody());
  }

  Widget buildBody() {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
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
        AppHelperFunctions.showToast('Payment Successful');
        // handle success
        Get.offAllNamed("/home");
      } else if (responseJSON["result"] == false) {
        AppHelperFunctions.showToast('Payment cancelled');
        // handle failure
        Get.offAllNamed("/home");
      }
    });
  }

  // void navigateToOrderSuccess() {
  //   // Navigator.pushAndRemoveUntil(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (_) => AppOrderStatusScreen(
  //   //       orderId: widget.orderId,
  //   //       statusString: message,
  //   //       status: status,
  //   //     ),
  //   //   ),
  //   //       (route) => false,
  //   // );
  // }

}
