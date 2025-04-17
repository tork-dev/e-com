import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/shop/model/sub_category_model.dart';
import '../../../utils/caching/caching_keys.dart';
import '../../../utils/caching/caching_utility.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../model/shop_data_model.dart';
import '../model/skin_type_model.dart';


class ShopRepositories{
  Future<ShopPageResponse> getFilteredProducts({required String queryString}) async {
    debugPrint("queryString $queryString");
    Uri url = Uri.parse("${AppApiEndPoints.shopProducts}$queryString");
    final response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return ShopPageResponse.fromJson(responseBody);
  }

  ///Shop Page Skin Type
  Future<SkinTypesResponse> getFilterPageSkinTypes() async {
    Uri url = Uri.parse(AppApiEndPoints.shopSkinTypes);
    final skinTypesCachedData = CachingUtility.getData(CachingKeys.skinTypesCachedData);
    if (skinTypesCachedData != null) {
      return skinTypesResponseFromJson(skinTypesCachedData);
    }
    final response = await http.get(url, headers: {
    });
    await CachingUtility.saveData(CachingKeys.skinTypesCachedData, response.body);
    return skinTypesResponseFromJson(response.body);
  }

  ///Sub Categories
  Future<List<ProductSubCategoryItem>> getSubCategories(String slug) async {
    final response = await http.get(Uri.parse('${AppApiEndPoints.subCategory}/$slug'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => ProductSubCategoryItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load product categories');
    }
  }
}