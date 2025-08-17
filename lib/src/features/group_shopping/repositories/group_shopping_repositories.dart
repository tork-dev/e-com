import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kirei/src/features/group_shopping/model/group_checkout_model.dart';
import 'package:kirei/src/features/group_shopping/model/group_shopping_groups.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../model/group_shopping_products_model.dart';

class GroupShoppingRepo {
  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<GroupShoppingProductsResponse> getGroupShoppingProducts() async {
    final response =
        await http.get(Uri.parse("${AppApiEndPoints.groupShoppingProducts}?source=app"), headers: {
          "Authorization": "Bearer $accessToken",
        });

    if (response.statusCode == 200) {
      return GroupShoppingProductsResponse.fromJson(response.body);
    } else {
      throw 'fetching issue';
    }
  }

  Future<GroupShoppingGroupsResponse> getGroupShoppingGroups() async {
    final response = await http.get(Uri.parse("${AppApiEndPoints.shoppingGroups}?source=app"), headers: {
      "Authorization": "Bearer $accessToken",
    });

    if (response.statusCode == 200) {
      return GroupShoppingGroupsResponse.fromJson(response.body);
    } else {
      throw 'fetching issue';
    }
  }

  Future<GroupShoppingCheckoutResponse> createAGroup(
      String apiEndPoint,
      int productId,
      String paymentMethod,
      String shippingName,
      String phone,
      String address,
      int cityId,
      int zoneId,
      int areaId,
      String note) async {
    final response = await http.post(Uri.parse(apiEndPoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode({
          "source" : "app",
          "product_id" : productId,
          "payment_method": paymentMethod,
          "shipping_name": shippingName,
          "shipping_phone": phone,
          "shipping_address": address,
          "shipping_city_id": cityId,
          "shipping_zone_id": zoneId,
          "shipping_area_id": areaId,
          "note": note,
        }));

    if (response.statusCode == 200) {
      return GroupShoppingCheckoutResponse.fromJson(response.body);
    } else {
      throw 'fetching issue';
    }
  }
}
