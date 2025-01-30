import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/home/model/home_featured_category_model.dart';
import 'package:kirei/src/features/home/model/home_products_model.dart';
import 'package:kirei/src/features/home/model/surprize_gift_model.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../../details/model/products_model.dart';
import '../model/device_token_model.dart';

class HomeRepositories {
  static Future<HomeProductResponse> getHomeProducts() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.homeProducts));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body.toString());
      return HomeProductResponse.fromJson(response.body);
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

  // static Future<HomeSlidersResponse> getHomeSliders() async {
  //   final response = await http.get(Uri.parse(AppApiEndPoints.homeSlider));
  //   if (response.statusCode == 200) {
  //     var responseBody = jsonDecode(response.body.toString());
  //     return HomeSlidersResponse.fromJson(responseBody);
  //   } else {
  //     throw Exception('Failed to load data: ${response.statusCode}');
  //   }
  // }



  static Future<DetailsProductsResponse> getTrendingProduct() async {
    final response = await http.get(
        Uri.parse("${AppApiEndPoints.trendingProduct}${AppLocalStorage().readData(LocalStorageKeys.gaipUserId)}"),
        headers: {});
    var responseBody = jsonDecode(response.body.toString());
    if (responseBody["result"] == true) {
      return DetailsProductsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<DeviceTokenUpdateResponse> getDeviceTokenUpdateResponse() async {
    print('sending fcm ${AppLocalStorage().readData(LocalStorageKeys.fcmToken)}');
    var postBody = jsonEncode({
      "device_token": AppLocalStorage().readData(LocalStorageKeys.fcmToken)
    });
    Uri url = Uri.parse(AppApiEndPoints.deviceToken);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
        },
        body: postBody);
    print('sended fcm ${AppLocalStorage().readData(LocalStorageKeys.fcmToken)}');
    print('posted body $postBody}');

    return deviceTokenUpdateResponseFromJson(response.body);
  }

  Future<SurprizeGiftResponse> getSurprizResponse(String phone) async {
    Uri url = Uri.parse(AppApiEndPoints.surpriseGift);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
      'phone' : phone
    }));
    return SurprizeGiftResponse.fromJson(response.body);
  }

  static Future<DetailsProductsResponse> getRecommendedProductForYou() async {
    final response = await http.get(
        Uri.parse("${AppApiEndPoints.recommendedProductForUser}${AppLocalStorage().readData(LocalStorageKeys.gaipUserId)}"),
        headers: {});
    var responseBody = jsonDecode(response.body.toString());
    if (responseBody["result"] == true) {
      return DetailsProductsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
