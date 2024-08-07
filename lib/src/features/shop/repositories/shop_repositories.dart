import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kirei/src/features/shop/model/sub_category_model.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../model/shop_data_model.dart';
import '../model/skin_type_model.dart';


class ShopRepositories{
  Future<ShopPageResponse> getFilteredProducts({
    required String searchName,
    required int pageNumber,
    required String sortKey,
    required String categories,
    required String skinType,
    required String tag,
    required String min,
    required String max,
    required String type,
    required String search,
    required String keyIngredients,
    required String goodFor,
  }) async {
    Map<dynamic, dynamic> parameters = {
      'page': pageNumber,
    };

    if (searchName != "") parameters['search'] = searchName;
    if (categories != "") {
      parameters['category'] = categories.toLowerCase().replaceAll(' ', '-');
    }
    if (sortKey != "") {
      parameters['order_by'] = sortKey.toLowerCase().replaceAll(' ', '-');
    }
    if (skinType != "") {
      parameters['skin_type'] = skinType.toLowerCase().replaceAll(' ', '-');
    }
    if (min != "") parameters['min_price'] = int.tryParse(min);
    if (max != "") parameters['max_price'] = int.tryParse(max);
    if (keyIngredients != "") {
      parameters['key_ingredients'] =
          keyIngredients.toLowerCase().replaceAll(' ', '-');
    }
    if (goodFor != "") {
      parameters['good_for'] = goodFor.toLowerCase().replaceAll(' ', '-');
    }
    if (tag != "") {
      parameters['tag'] = tag.toLowerCase().replaceAll(' ', '-');
    }
    if (type != "") {
      parameters['type'] = type.toLowerCase().replaceAll(' ', '-');
    }
    if (search != "") {
      parameters['search'] = search.toLowerCase().replaceAll(' ', '-');
    }

    // Constructing the query string manually
    String queryString = parameters.entries
        .map((entry) =>
    '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    // Append gaip_user_id=null at the end
    queryString += '&gaip_user_id=null';

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