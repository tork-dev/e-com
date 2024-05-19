import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:torganic/src/features/cart/model/card_add_response_model.dart';
import 'package:torganic/src/features/cart/model/cart_delete_response_model.dart';
import 'package:torganic/src/features/cart/model/cart_get_response_model.dart';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CartRepositories {

  final int userId = AppLocalStorage().readData(LocalStorageKeys.userId);
  final String version = AppLocalStorage().readData(
      LocalStorageKeys.appVersion);
  final dynamic accessToken = AppLocalStorage().readData(
      LocalStorageKeys.accessToken);


  /// Add To Cart
  Future<AddToCartResponse> getCartAddResponse(int id,
      //String variant,
      int quantity,
      dynamic preorderAvailable,) async {
    var postBody = jsonEncode({
      "id": id,
      "user_id": userId,
      "quantity": quantity,
      "is_preorder": "$preorderAvailable",
      "version": version,
    });
    Uri url = Uri.parse(AppApiEndPoints.addToCart);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);
    return AddToCartResponse.fromJson(jsonDecode(response.body));
  }

  /// Get The Cart Products
  Future<List<CartItemGetResponse>> getCartProducts() async {
    var postBody = jsonEncode({
      "version" : version
    });
    final response = await http.post(Uri.parse(AppApiEndPoints.cartProducts),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CartItemGetResponse.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load cart Products data');
    }
  }


  Future<CartDeleteResponse> getCartDeleteResponse(int cartId) async {

    Uri url = Uri.parse("${AppApiEndPoints.cartProductsDelete}/$cartId");
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return CartDeleteResponse.fromJson(responseBody);
    }else{
      throw 'Something went wrong';
    }


  }
}
