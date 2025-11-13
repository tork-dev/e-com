import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/cart/model/card_add_response_model.dart';
import 'package:kirei/src/features/cart/model/cart_delete_response_model.dart';
import 'package:kirei/src/features/cart/model/cart_local_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/logging/logger.dart';
import '../../home/model/request_stock_model.dart';
import '../model/cart_update_response_model.dart';
import '../services/cart_services.dart';

class CartRepositories {
  final dynamic accessToken = AppLocalStorage().readData(
    LocalStorageKeys.accessToken,
  );

  /// Add To Cart
  Future<AddToCartResponse> getCartAddResponse(
    int id,
    int quantity,
    dynamic preorderAvailable,
  ) async {
    var postBody = jsonEncode({
      "source": "app",
      "id": id,
      "quantity": quantity,
      "is_preorder": "$preorderAvailable",
      'app_info': await AppHelperFunctions.appInfo(),
    });

    Log.d(postBody);

    Uri url = Uri.parse(AppApiEndPoints.addToCart);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );
    Log.d("Url: $url, post body: $postBody, Status code: ${response.statusCode}, response: ${response.body}");
    return AddToCartResponse.fromJson(response.body);
  }

  /// Get The Cart Products
  Future<List<CartItemLocal>> getCartProducts() async {

    Uri url = Uri.parse(AppApiEndPoints.cartProducts);
    var postBody = jsonEncode({
      "source": "app",
      "app_info": await AppHelperFunctions.appInfo(),
    });
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );
    Log.d("Url: $url, post body: $postBody, Status code: ${response.statusCode}, response: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      Log.d('cart response : $jsonResponse');

      List<CartItemLocal> cartItems = [];

      for (var group in jsonResponse) {
        var items = group['cart_items'] as List<dynamic>;
        for (var item in items) {
          cartItems.add(CartItemLocal.fromJson(item));
        }
      }

      return cartItems;
    } else {
      throw Exception('Failed to load cart Products data');
    }
  }


  ///Cart Quantity Update
  Future<CartUpdateResponse> getCartQuantityUpdate(
    int productId,
    int productQuantity,
  ) async {
    Uri url = Uri.parse(AppApiEndPoints.cartQuantityUpdate);
    Log.d("cart Change Quantity");

    var postBody = jsonEncode({
      "source": "app",
      "id": productId,
      "quantity": productQuantity,
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );
    Log.d("Url: $url, post body: $postBody, Status code: ${response.statusCode}, response: ${response.body}");

    return CartUpdateResponse.fromJson(jsonDecode(response.body));
  }

  ///Delete Cart Product
  Future<CartDeleteResponse> getCartDeleteResponse(int cartId) async {
    Uri url = Uri.parse(
      "${AppApiEndPoints.cartProductsDelete}/$cartId?source=app",
    );
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    Log.d("Url: $url, Status code: ${response.statusCode}, response: ${response.body}");
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return CartDeleteResponse.fromJson(responseBody);
    } else {
      throw 'Something went wrong';
    }
  }

  // Future<CheckoutCartUpdateResponse> getCartProcessResponse({
  //   required String cartIds,
  //   required String cartQuantities,
  // }) async {
  //   var postBody = jsonEncode({
  //     "source": "app",
  //     "cart_ids": cartIds,
  //     "cart_quantities": cartQuantities,
  //   });
  //   Log.d(postBody);
  //   Uri url = Uri.parse(AppApiEndPoints.proceedToCheckout);
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $accessToken",
  //     },
  //     body: postBody,
  //   );
  //
  //   Log.d(url.toString());
  //   Log.d(response.body.toString());
  //   return CheckoutCartUpdateResponse.fromJson(jsonDecode(response.body));
  // }

  Future<ProductRequestResponse> getRequestStock({
    required int productId,
  }) async {
    Uri url = Uri.parse("${AppApiEndPoints.requestStock}$productId");
    final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({"source": "app"}),
    );

    Log.d("Url: $url, Status code: ${response.statusCode}, response: ${response.body}");
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body.toString());
      return ProductRequestResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  /// Bulk add to cart
  Future<void> bulkAddToCart() async {
    debugPrint('bulkAddToCart called');

    List<int> productIds = [];
    List<int> productQuantities = [];

    for (var product in CartService.getCartItems()) {
      productIds.add(product.productId!);
      productQuantities.add(product.quantity!);
    }

    final appInfo = await AppHelperFunctions.appInfo();

    var postBody = jsonEncode({
      "product_ids_arr": productIds,
      "product_quantities_arr": productQuantities,
      "app_info": appInfo,
    });

    Uri url = Uri.parse(AppApiEndPoints.bulkAddToCart);

    debugPrint("URL: $url");
    debugPrint("Access Token: $accessToken");
    debugPrint("POST Body: $postBody");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody,
      );
      Log.d("Url: $url, post body: $postBody, Status code: ${response.statusCode}, response: ${response.body}");
    } catch (e) {
      debugPrint("Error in bulkAddToCart: $e");
    }
  }

}
