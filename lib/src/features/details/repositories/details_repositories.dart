import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../utils/constants/app_api_end_points.dart';
import '../model/product_details_model.dart';

class DetailsRepositories{


  static Future<ProductDetailsResponse> getProductDetails(int id) async {
    final response = await http.get(Uri.parse(AppApiEndPoints.productDetails+id.toString()), headers: {

    });
    var responseBody = jsonDecode(response.body.toString());
    if (jsonDecode(response.body)["result"] == true) {
      return ProductDetailsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}