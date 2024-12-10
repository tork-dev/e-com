import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kirei/src/features/purchase_history/model/order_re_order_model.dart';
import 'package:kirei/src/features/purchase_history/model/purchase_history_details_model.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../model/product_history_items_model.dart';
import '../model/purchase_history_model.dart';

class PurchaseHistoryRepositories {

  final int userId = AppLocalStorage().readData(LocalStorageKeys.userId);
  final String version =
      AppLocalStorage().readData(LocalStorageKeys.appVersion);
  final dynamic accessToken =
      AppLocalStorage().readData(LocalStorageKeys.accessToken);


  ///Get Order History list
  Future<PurchaseHistoryResponse> getPurchaseHistoryList() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.purchaseHistory),
        headers: {
          "Authorization": "Bearer $accessToken",
        },);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return PurchaseHistoryResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load cart Products data');
    }
  }

  /// Get Purchase Details
  Future<PurchaseHistoryDetailsResponse> getPurchaseHistoryDetails(int id) async {
    final response = await http.get(Uri.parse('${AppApiEndPoints.purchaseHistoryDetails}/$id'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return PurchaseHistoryDetailsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load cart Products data');
    }
  }

  /// Get Purchase items Details
  Future<PurchaseHistoryItemsResponse> getPurchaseHistoryItemDetails(int id) async {
    final response = await http.get(Uri.parse('${AppApiEndPoints.purchaseHistoryItem}/$id'),
      headers: {
        "Authorization": "Bearer $accessToken",
      },);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return PurchaseHistoryItemsResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load cart Products data');
    }
  }


  /// Re-Order Purchase Item
  Future<ReOrderResponse> getReOrder(int id) async{
    final response = await http.get(Uri.parse('${AppApiEndPoints.reOrder}/$id'), headers: {
      "Authorization": "Bearer $accessToken",
    });
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return ReOrderResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }


  // Future<dynamic> getReOrder({@required int id = 0}) async {
  //   Uri url = Uri.parse("${ENDP.RE_ORDER}"+id.toString());
  //
  //   final response = await http.get(url, headers: {
  //     "Authorization": "Bearer ${access_token.$}",
  //     "App-Language": app_language.$,
  //   });
  //   print("ReOrder Message: ${response.body}");
  //   //return orderDetailResponseFromJson(response.body);
  //   return jsonDecode(response.body);
  // }



}
