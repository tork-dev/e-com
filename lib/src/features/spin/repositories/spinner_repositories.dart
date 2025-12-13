import 'dart:convert';

import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../model/spinner_coupon_list_response.dart';
import 'package:http/http.dart' as http;
import '../model/spinner_coupon_response.dart';


class SaleSpinnerRepositories{

  Future<SaleSpinnerCouponList> getCouponList ()async{
    final response = await http.get(Uri.parse(AppApiEndPoints.spinnerCouponList));
    return SaleSpinnerCouponList.fromJson(response.body);
  }
  
  Future<SaleSpinnerCouponResponse> getSelectedCoupon() async{
    final response = await http.post(
        Uri.parse(AppApiEndPoints.spinnerSelectedCoupon),
      headers: {
        "Authorization": "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
      },
      body: jsonEncode({
        "source" : "app",
    })
    );
    return SaleSpinnerCouponResponse.fromJson(response.body);
  }
}