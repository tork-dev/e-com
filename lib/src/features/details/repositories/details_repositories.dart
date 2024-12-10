import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/details/model/products_model.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../model/product_details_model.dart';

class DetailsRepositories{

  static final userId = AppLocalStorage().readData(LocalStorageKeys.userId);
  static final gaipUserId = AppLocalStorage().readData(LocalStorageKeys.gaipUserId);


  static Future<ProductDetailsResponse> getProductDetails(String slug) async {
    final response = await http.get(Uri.parse(AppApiEndPoints.productDetails+slug), headers: {

    });
    var responseBody = jsonDecode(response.body.toString());
    if (responseBody["result"] == true) {
      return ProductDetailsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future<DetailsProductsResponse> getRelatedProducts(String slug) async {
    final response = await http.get(Uri.parse("${AppApiEndPoints.relatedProduct}$slug?gaip_user_id=$gaipUserId"), headers: {

    });
    var responseBody = jsonDecode(response.body.toString());
    if (responseBody["result"] == true) {
      return DetailsProductsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future<DetailsProductsResponse> getRecommendedProduct() async {
    final response = await http.get(Uri.parse("${AppApiEndPoints.recommendedProduct}$gaipUserId"), headers: {

    });
    var responseBody = jsonDecode(response.body.toString());
    if (responseBody["result"] == true) {
      return DetailsProductsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}