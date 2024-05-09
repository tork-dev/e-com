import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:torganic/src/features/home/model/home_products_model.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/popups/loaders.dart';

import '../../../utils/constants/app_api_end_points.dart';

class HomeRepositories{
  static Future<HomeProductResponse> getHomeProducts() async {
      final response = await http.get(Uri.parse(AppApiEndPoints.homeProducts));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body.toString());
        return HomeProductResponse.fromJson(responseBody);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
  }
}