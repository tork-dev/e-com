import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/features/bottom_navigation/convex_bottom_navigation.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'group_order_status_page.dart';

class GroupBkashScreen extends StatefulWidget {
  final String bkashInitialUrl;


  const GroupBkashScreen({
    super.key,
    required this.bkashInitialUrl,
  });

  @override
  _GroupBkashScreenState createState() => _GroupBkashScreenState();
}

class _GroupBkashScreenState extends State<GroupBkashScreen> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            Log.i('navigation finished $url');
            if (url.contains("result=true&message=Successfully%20Paid")) {
              AppHelperFunctions.showToast('Successfully Paid');
              navigateToOrderSuccess('Payment Successful', true);
            } else if (url.contains("result=false&message=Payment%20Cancelled") ) {
              AppHelperFunctions.showToast("Payment Cancelled");
              navigateToOrderSuccess("Payment Cancelled", false);
            }else if(url.contains("result=false&message=Payment%20Failed")){
              navigateToOrderSuccess("Payment Failed", false);
            }
          },
          onWebResourceError: (error) {
            Log.i('error in payment $error');
            navigateToOrderSuccess("Payment cancel", false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.bkashInitialUrl));
    }

  @override
  Widget build(BuildContext context) {

    return AppLayoutWithBackButton(
        showCustomLeading: true,
        backToHome: true,
        showBackButton: false,
        customLeadingIcon: Icons.arrow_back_ios_new,
      title: const Text('Pay with Bkash', style: TextStyle(color: AppColors.primary),),
        leadingOnPress: (){
          Log.d('working');
        Get.offAllNamed("/home");
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
    Log.d('Reading response');
    webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      var decodedJSON = jsonDecode(data.toString());
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);

      Log.d('Bkash json Response: $decodedJSON');

      if (responseJSON["result"] == true) {
        Log.d('success');
        navigateToOrderSuccess("Payment Successful", true);
      } else if (responseJSON["result"] == false) {
        Log.d("payment cancel");
        navigateToOrderSuccess("Something went wrong", false);
      }
    });
  }

  void navigateToOrderSuccess(String message, bool status) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => GroupOrderStatusScreen(
          statusString: message,
          status: status,
        ),
      ),
          (route) => false,
    );
  }

}
