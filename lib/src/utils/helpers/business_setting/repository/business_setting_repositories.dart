import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../../../caching/caching_keys.dart';
import '../../../caching/caching_utility.dart';
import '../../../logging/logger.dart';
import '../model/business_setting_response.dart';


class BusinessSettingRepository{
  Future<BusinessSettingResponse> getBusinessSettingList()async{

    final businessSettingCachedData = CachingUtility.getData(CachingKeys.featuredCategoryCachedData);
    if (businessSettingCachedData != null) {
      return BusinessSettingResponse.fromJson(businessSettingCachedData);
    }
    Uri url = Uri.parse(AppApiEndPoints.businessSettings);
    final response = await http.get(url);
    if(response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      Log.d('business data $responseBody');
      await CachingUtility.saveData(CachingKeys.businessSettingsCachedData, response.body);
      return BusinessSettingResponse.fromJson(response.body);
    }else{
      throw 'not responded';
    }
  }
}