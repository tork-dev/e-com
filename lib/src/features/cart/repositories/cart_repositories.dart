import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kirei/src/features/cart/model/card_add_response_model.dart';
import 'package:kirei/src/features/cart/model/cart_delete_response_model.dart';
import 'package:kirei/src/features/cart/model/cart_get_response_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../home/model/request_stock_model.dart';
import '../model/cart_update_response_model.dart';
import '../model/checkout_cart_update_model.dart';

class CartRepositories {
  final int userId = AppLocalStorage().readData(LocalStorageKeys.userId);
  final dynamic accessToken =
      AppLocalStorage().readData(LocalStorageKeys.accessToken);

  /// Add To Cart
  Future<AddToCartResponse> getCartAddResponse(
    int id,
    int quantity,
    dynamic preorderAvailable,
  ) async {
    var postBody = jsonEncode({
      "id": id,
      "user_id": userId,
      "quantity": quantity,
      "is_preorder": "$preorderAvailable",
      'app_info': await AppHelperFunctions.appInfo(),
    });

    Uri url = Uri.parse(AppApiEndPoints.addToCart);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );
    return AddToCartResponse.fromJson(response.body);
  }

  /// Get The Cart Products
  Future<List<CartItemGetResponse>> getCartProducts() async {
    var postBody = jsonEncode({
      "app_info": await AppHelperFunctions.appInfo()
    });
    final response = await http.post(Uri.parse(AppApiEndPoints.cartProducts),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print('cart response : $jsonResponse');
      return jsonResponse
          .map((data) => CartItemGetResponse.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load cart Products data');
    }
  }

  ///Cart Quantity Update
  Future<CartUpdateResponse> getCartQuantityUpdate(
      productId, int productQuantity) async {
    Uri url = Uri.parse(AppApiEndPoints.cartQuantityUpdate);
    print("cart Change Quantity");

    var postBody = jsonEncode({
      "id": productId,
      "quantity": productQuantity,
    });
    print(postBody);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );
    print("access token $accessToken");

    print("cart Quantity res ${response.body}");

    return CartUpdateResponse.fromJson(jsonDecode(response.body));
  }

  ///Delete Cart Product
  Future<CartDeleteResponse> getCartDeleteResponse(int cartId) async {
    Uri url = Uri.parse("${AppApiEndPoints.cartProductsDelete}/$cartId");
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return CartDeleteResponse.fromJson(responseBody);
    } else {
      throw 'Something went wrong';
    }
  }

  Future<CheckoutCartUpdateResponse> getCartProcessResponse(
      {required String cartIds, required String cartQuantities}) async {
    var postBody =
        jsonEncode({"cart_ids": cartIds, "cart_quantities": cartQuantities});
    print(postBody);
    Uri url = Uri.parse(AppApiEndPoints.proceedToCheckout);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    print(url);
    print(response.body.toString());
    return CheckoutCartUpdateResponse.fromJson(jsonDecode(response.body));
  }

  Future<ProductRequestResponse> getRequestStock(
      {required int productId}) async {
    final response = await http
        .post(Uri.parse("${AppApiEndPoints.requestStock}$productId"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body.toString());
      return ProductRequestResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
