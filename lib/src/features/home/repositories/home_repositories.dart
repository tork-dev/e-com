import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:torganic/src/common/api_endpoints/api_endpoints.dart';
import 'package:torganic/src/features/home/model/home_products_model.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/popups/loaders.dart';

class HomeRepositories{
  static Future<HomeProductResponse> getHomeProducts() async {
      final response = await http.get(Uri.parse(ApiEndPoints.homeProducts));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body.toString());
        print(responseBody);
        return HomeProductResponse.fromJson(responseBody);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
  }
}