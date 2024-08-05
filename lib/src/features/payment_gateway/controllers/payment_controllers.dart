
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/payment_gateway/stripe/repository/stripe_repository.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';

class PaymentController extends GetxController{
  static PaymentController get instance => Get.find();

  final stripePaymentRepo = Get.put(StripeRepository());


  /// Bkash Payment
  Future<void> paymentCheckoutWithBkash(double amount) async {
    // sandbox
    final flutterBkash = FlutterBkash();

    // production
    // final flutterBkash = FlutterBkash(
    //   bkashCredentials: BkashCredentials(
    //     username: "app_username",
    //     password: "app_password",
    //     appKey: "app_key",
    //     appSecret: "app_secret",
    //     isSandbox: false,
    //   ),
    // );

    // Goto BkashPayment page & pass the params
    try {
      FullScreenLoader.openLoadingDialog('Processing..', AppImages.loading);
      // call pay method to pay without agreement as parameter pass the context, amount, merchantInvoiceNumber
      final result = await flutterBkash.pay(
        context: Get.overlayContext!,
        // need the context as BuildContext
        amount: amount,
        // need it double type
        merchantInvoiceNumber: "tranId",
      );

      // if the payment is success then show the log
      print(result.toString());

      // if the payment is success then show the snack-bar
      AppHelperFunctions.showSimpleSnackBar("(Success) tranId: ${result.trxId}");
    } on BkashFailure catch (e, st) {// if something went wrong then show the log
      print(e.message);
      print(st);

      // if something went wrong then show the snack-bar
      AppHelperFunctions.showSimpleSnackBar(e.message);
    } catch (e, st) {
      // if something went wrong then show the log
      print(e);
      print(st);

      // if something went wrong then show the snack-bar
      AppHelperFunctions.showSimpleSnackBar("Something went wrong");
    }
    FullScreenLoader.stopLoading();
    return;
  }

  /// SSl Payment
  Future<void> paymentCheckoutWithSSL() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
        //ipn_url: "www.ipnurl.com",
        //multi_card_name: formData['multicard'],
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: "mobil5fe45035efe16",
        store_passwd: "mobil5fe45035efe16@ssl",
        total_amount: 100.00,
        tran_id: "1231123131212",
      ),
    );
    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        Fluttertoast.showToast(
          msg: "Transaction is Failed....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (result.status!.toLowerCase() == "closed") {
        Fluttertoast.showToast(
          msg: "SDK Closed by User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
            msg:
            "Transaction is ${result.status} and Amount is ${result.amount}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> paymentCheckoutWithStripe () async{
    FullScreenLoader.openLoadingDialog('Processing', AppImages.searching);
    await stripePaymentRepo.initPaymentSheet();

    try{
      FullScreenLoader.stopLoading();
      await Stripe.instance.presentPaymentSheet();
      AppHelperFunctions.showSnackBarWithDesign(title: 'Successfully paid', backgroundColor: AppColors.primary);
      // ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
      //   const SnackBar(content: Text('Successfully paid')),
      // );
    }catch(e){
      AppHelperFunctions.showSnackBarWithDesign(title: 'Payment Failed', backgroundColor: AppColors.primary);
      // ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
      //   const SnackBar(content: Text('Payment Failed')),
      // );
    }
  }
}