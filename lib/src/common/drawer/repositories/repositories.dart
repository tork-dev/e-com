import 'dart:convert';
import '../../../utils/constants/app_api_end_points.dart';
import '../model/all_category_model.dart';
import 'package:http/http.dart' as http;

class DrawerRepositories{

  Future<List<AllCategory>> getAllNewCategories() async {
    final Uri url = Uri.parse(AppApiEndPoints.allNewCategories);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => AllCategory.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<AllCategory>> getAllCategories() async {
    final Uri url = Uri.parse(AppApiEndPoints.allCategories);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => AllCategory.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}