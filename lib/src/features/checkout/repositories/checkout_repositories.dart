import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kirei/src/features/checkout/model/checkout_summary_respopnse.dart';
import 'package:kirei/src/features/checkout/model/coupon_remove_model.dart';
import 'package:kirei/src/features/checkout/model/order_create_model.dart';
import 'package:kirei/src/features/checkout/model/payment_types_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/coupon_apply_model.dart';

class CheckoutRepositories {

  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);
  final userid = AppLocalStorage().readData(LocalStorageKeys.userId);


  Future<CheckoutSummaryResponse> getCartSummaryResponse() async {
    Uri url = Uri.parse(AppApiEndPoints.checkoutSummary);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    return CheckoutSummaryResponse.fromJson(jsonDecode(response.body));
  }


  Future<List<PaymentMethodResponse>> getPaymentMethods() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.paymentTypes));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return PaymentMethodResponse.fromJsonList(jsonResponse);
    } else {
      throw Exception('Failed to load payment methods');
    }
  }

  Future<CouponResponse> getCouponApplyResponse(
      {required String couponCode}) async {
    var postBody =
    jsonEncode({
      "coupon_code": couponCode
    });
    print(postBody);

    Uri url = Uri.parse(AppApiEndPoints.couponAdd);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    print(response.body.toString());

    return CouponResponse.fromJson(jsonDecode(response.body));
  }

  Future<CouponRemoveResponse> getCouponRemoveResponse() async {
    var postBody = jsonEncode({"user_id": userid});

    Uri url = Uri.parse(AppApiEndPoints.couponRemove);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);
    return CouponRemoveResponse.fromJson(jsonDecode(response.body));
  }

  // Future<CouponRemoveResponse> getCouponRemoveResponse() async {
  //   var postBody = jsonEncode({"user_id": userid});
  //
  //   Uri url = Uri.parse(AppApiEndPoints.couponRemove);
  //   final response = await http.post(url,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $accessToken",
  //       },
  //       body: postBody);
  //
  //   return couponRemoveResponseFromJson(response.body);
  // }

  Future<OrderCreateResponse> getOrderCreateResponseFromCod({required Map<String, dynamic> requestBody}) async {
    var postBody = jsonEncode(requestBody);
    Uri url = Uri.parse(AppApiEndPoints.placeOrder);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: postBody,
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return OrderCreateResponse.fromJson(responseBody);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to create order. Status code: ${response.statusCode}');
    }
  }
}