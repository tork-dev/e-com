import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirei/src/common/drawer/model/all_category_model.dart';
import 'package:kirei/src/features/home/model/home_featured_category_model.dart';
import 'package:kirei/src/features/home/model/home_products_model.dart';
import 'package:kirei/src/features/home/model/request_stock_model.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/popups/loaders.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../../details/model/products_model.dart';
import '../model/device_token_model.dart';
import '../model/home_sliders_model.dart';

class HomeRepositories {
  static Future<HomeProductResponse> getHomeProducts() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.homeProducts));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body.toString());
      return HomeProductResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<List<FeaturedCategory>> getHomeFeaturedCategories() async {
    Uri url = Uri.parse(AppApiEndPoints.homeFeaturedCategory);
    final response = await http.get(url, headers: {
      //"App-Language": app_language.$,
    });
    return featuredCategoryListFromJson(response.body);
  }

  static Future<HomeSlidersResponse> getHomeSliders() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.homeSlider));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body.toString());
      return HomeSlidersResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }



  static Future<DetailsProductsResponse> getTrendingProduct() async {
    final response = await http.get(
        Uri.parse("${AppApiEndPoints.trendingProduct}${null}"),
        headers: {});
    var responseBody = jsonDecode(response.body.toString());
    if (responseBody["result"] == true) {
      return DetailsProductsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<DeviceTokenUpdateResponse> getDeviceTokenUpdateResponse() async {
    var postBody = jsonEncode({
      "device_token": {AppLocalStorage().readData(LocalStorageKeys.fcmToken)}
    });

    Uri url = Uri.parse(AppApiEndPoints.deviceToken);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
        },
        body: postBody);

    print(response.body.toString());
    return deviceTokenUpdateResponseFromJson(response.body);
  }

}
