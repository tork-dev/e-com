import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kirei/src/utils/popups/full_screen_loader.dart';

class StripeRepository extends GetxController {


  static const String baseUrl = "https://api.stripe.com/v1";
  static final String secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;

  Future createPaymentIntent() async {

    const String url = '$baseUrl/payment_intents';

    final body = {
      'amount': (200 * 100).toString(),
      'currency': 'usd'.toLowerCase(),
      'automatic_payment_methods[enabled]': 'true'
    };

    final response = await http.post(Uri.parse(url),
        headers: {
      'Authorization' : "Bearer $secretKey",
          'Content-Type' : 'application/x-www-form-urlencoded'
    },
      body: body
    );

     if(response.statusCode == 200){
       var responseBody = jsonDecode(response.body);
       print(responseBody.toString());
       return responseBody;
     }else{
       print('there is an error');
     }
  }


  Future <void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await createPaymentIntent();

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Test pay',
          paymentIntentClientSecret: data["client_secret"],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

}
