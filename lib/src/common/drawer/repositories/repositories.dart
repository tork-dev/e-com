import 'dart:convert';
import '../../../utils/caching/caching_keys.dart';
import '../../../utils/caching/caching_utility.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../model/all_category_model.dart';
import 'package:http/http.dart' as http;

class DrawerRepositories{

  Future<List<AllCategory>> getAllNewCategories() async {
    final allNewCategoriesCachedData = CachingUtility.getData(CachingKeys.allCategoryNewCachedData);

    if (allNewCategoriesCachedData != null) {
      // ✅ Decode the cached JSON string
      final List<dynamic> jsonResponse = json.decode(allNewCategoriesCachedData);
      return jsonResponse.map((category) => AllCategory.fromJson(category)).toList();
    }

    final Uri url = Uri.parse(AppApiEndPoints.allNewCategories);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // ✅ Save the response as a string
      await CachingUtility.saveData(CachingKeys.allCategoryNewCachedData, response.body);

      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((category) => AllCategory.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }


  Future<List<AllCategory>> getAllCategories() async {
    final allCategoriesCachedData = CachingUtility.getData(
        CachingKeys.allCategoryNewCachedData);

    if (allCategoriesCachedData != null) {
      // ✅ Decode the cached JSON string
      final List<dynamic> jsonResponse = json.decode(allCategoriesCachedData);
      return jsonResponse
          .map((category) => AllCategory.fromJson(category))
          .toList();
    }

    final Uri url = Uri.parse(AppApiEndPoints.allCategories);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // ✅ Save the response as a string
      await CachingUtility.saveData(
          CachingKeys.allCategoryNewCachedData, response.body);

      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => AllCategory.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}