import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../model/business_setting_response.dart';


class BusinessSettingRepository{
  Future<BusinessSettingResponse> getBusinessSettingList()async{
    Uri url = Uri.parse(AppApiEndPoints.businessSettings);
    final response = await http.get(url);
    if(response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print('business datas $responseBody');
      return BusinessSettingResponse.fromJson(responseBody);
    }else{
      throw 'not responded';
    }
  }
}