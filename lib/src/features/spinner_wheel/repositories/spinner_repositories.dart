import 'package:kirei/src/utils/constants/app_api_end_points.dart';

import '../model/spinner_coupon_list_response.dart';
import 'package:http/http.dart' as http;
class SpinnerRepositories{


  Future<SpinnerCouponList> getCouponList ()async{
    final response = await http.get(Uri.parse(AppApiEndPoints.spinnerCouponList));
    return SpinnerCouponList.fromJson(response.body);
  }
}