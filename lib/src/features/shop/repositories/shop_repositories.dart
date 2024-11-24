import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kirei/src/features/shop/model/sub_category_model.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../model/shop_data_model.dart';
import '../model/skin_type_model.dart';


class ShopRepositories{
  Future<ShopPageResponse> getFilteredProducts({required String queryString}) async {
    // Construct the final URL
    Uri url = Uri.parse("${AppApiEndPoints.shopProducts}$queryString");
    print(url);

    final response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    // print('this is response ${responseBody["result"] == true}');

    return ShopPageResponse.fromJson(responseBody);
  }

  ///Shop Page Skin Type
  Future<SkinTypesResponse> getFilterPageSkinTypes() async {
    Uri url = Uri.parse(AppApiEndPoints.shopSkinTypes);
    final response = await http.get(url, headers: {
    });
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