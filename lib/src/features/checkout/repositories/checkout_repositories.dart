import 'dart:async';
import 'dart:convert';

import 'package:kirei/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:kirei/src/features/checkout/model/checkout_summary_respopnse.dart';
import 'package:kirei/src/features/checkout/model/coupon_remove_model.dart';
import 'package:kirei/src/features/checkout/model/order_create_model.dart';
import 'package:kirei/src/features/checkout/model/payment_types_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/logging/logger.dart';
import '../../authentication/model/login_model.dart';
import '../model/coupon_apply_model.dart';

class CheckoutRepositories {
  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  // Future<CheckoutSummaryResponse> getCartSummaryResponse(int cityID) async {
  //   Uri url = Uri.parse("${AppApiEndPoints.checkoutSummary}?city_id=$cityID&source=app");
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $accessToken",
  //     },
  //   );
  //   return CheckoutSummaryResponse.fromJson(jsonDecode(response.body));
  // }

  Future<CheckoutSummaryResponse> getCartSummaryResponse({
    int? cityID,
    String? couponCode,
    required List<int> cartProductIds,
    required List<int> cartQuantities,
  }) async {
    var postBody = jsonEncode({
      "product_ids_arr": cartProductIds,
      "product_quantities_arr": cartQuantities,
      "coupon_code": couponCode,
      "city_id": cityID,
      "app_info": await AppHelperFunctions.appInfo(),
    });
    Uri url = Uri.parse(AppApiEndPoints.checkoutSummary);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );
    return CheckoutSummaryResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<PaymentMethodResponse>> getPaymentMethods() async {
    final response = await http.get(
      Uri.parse("${AppApiEndPoints.paymentTypes}?source=app"),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return PaymentMethodResponse.fromJsonList(jsonResponse);
    } else {
      throw Exception('Failed to load payment methods');
    }
  }

  Future<CouponResponse> getCouponApplyResponse({
    required String couponCode,
  }) async {
    var postBody = jsonEncode({
      "source": "app",
      "coupon_code": couponCode,
      'app_info': await AppHelperFunctions.appInfo(),
    });
    Log.d(postBody);

    Uri url = Uri.parse(AppApiEndPoints.couponAdd);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );

    Log.d(response.body.toString());

    return CouponResponse.fromJson(jsonDecode(response.body));
  }

  Future<CouponRemoveResponse> getCouponRemoveResponse() async {
    var postBody = jsonEncode({
      "source": "app",
      'app_info': await AppHelperFunctions.appInfo(),
    });

    Uri url = Uri.parse(AppApiEndPoints.couponRemove);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );
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

  Future<OrderCreateResponse> getOrderCreateResponseFromCod({
    required Map<String, dynamic> requestBody,
  }) async {
    var postBody = jsonEncode(requestBody);
    Uri url = Uri.parse(AppApiEndPoints.placeOrder);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return OrderCreateResponse.fromJson(responseBody);
    } else {
      Log.d('Request failed with status: ${response.statusCode}');
      Log.d('Response body: ${response.body}');
      throw Exception(
        'Failed to create order. Status code: ${response.statusCode}',
      );
    }
  }
  Future<OrderCreateResponse> sendCheckoutOtp(String phone) async{
    var postBody = jsonEncode({
      "email": phone,
    });
    Uri url = Uri.parse(AppApiEndPoints.sendCheckoutOtp);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: postBody,
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return OrderCreateResponse.fromJson(responseBody);
    } else {
      Log.d('Request failed with status: ${response.statusCode}');
      Log.d('Response body: ${response.body}');
      throw Exception(
        'Failed to create order. Status code: ${response.statusCode}',
      );

    }
  }
  Future<AppLoginResponse> verifyCheckoutOtp({required String phone, required String name, required String otp}) async{
    var postBody = jsonEncode({
      "email": phone,
      "name": name,
      "otp_code": otp,
    });
    Uri url = Uri.parse(AppApiEndPoints.verifyCheckoutOtp);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: postBody,
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return AppLoginResponse.fromJson(responseBody);
    } else {
      Log.d('Request failed with status: ${response.statusCode}');
      Log.d('Response body: ${response.body}');
      throw Exception(
        'Failed to create order. Status code: ${response.statusCode}',
      );
    }
  }
}
