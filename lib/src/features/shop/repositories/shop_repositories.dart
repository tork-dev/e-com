import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../utils/constants/app_api_end_points.dart';
import '../model/shop_data_model.dart';


class ShopRepositories{
  Future<ShopPageResponse> getFilteredProducts({
    String name = "",
    int page = 1,
    String sortKey = "",
    String categories = "",
    String skinType = "",
    String tag = "",
    String min = "",
    String max = "",
    String type = "",
    String search = "",
    String keyIngredients = "",
    String goodFor = "",
  }) async {
    Map<dynamic, dynamic> parameters = {
      'page': page,
      'order_by': sortKey,
    };

    if (name != "") parameters['search'] = name;
    if (categories != "") {
      parameters['category'] = categories.toLowerCase().replaceAll(' ', '-');
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
      parameters['search'] = type.toLowerCase().replaceAll(' ', '-');
    }
    // Constructing the query string manually
    String queryString = parameters.entries
        .map((entry) =>
    '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    // Append gaip_user_id=null at the end
    queryString += '&gaip_user_id=null';

    // Construct the final URL
    Uri url =
    Uri.parse("${AppApiEndPoints.shopProducts}$queryString");
    print(url);

    final response = await http.get(url, headers: {
      //"App-Language": app_language.$,
    });
    return ShopPageResponse.fromJson(jsonDecode(response.body));
  }
}