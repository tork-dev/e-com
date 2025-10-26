import 'dart:convert';

import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../model/spinner_coupon_list_response.dart';
import 'package:http/http.dart' as http;
import '../model/spinner_coupon_response.dart';


class SpinnerRepositories{

  Future<SpinnerCouponList> getCouponList ()async{
    final response = await http.get(Uri.parse(AppApiEndPoints.spinnerCouponList));
    return SpinnerCouponList.fromJson(response.body);
  }
  
  Future<SpinnerCouponResponse> getSelectedCoupon(String accessToken) async{
    final response = await http.post(
        Uri.parse(AppApiEndPoints.spinnerSelectedCoupon),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({
        "source" : "app",
    })
    );
    return SpinnerCouponResponse.fromJson(response.body);
  }
}