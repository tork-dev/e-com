import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../model/cart_delete_response_model.dart';
import '../model/cart_get_response_model.dart';
import '../model/cart_update_response_model.dart';
import '../repositories/cart_repositories.dart';


class CartController extends GetxController {
  static CartController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> cartKey = GlobalKey<ScaffoldState>();
  RxList<CartItemGetResponse> allCartProducts = <CartItemGetResponse>[].obs;
  Rx<CartDeleteResponse> cartProductDeleteResponse = CartDeleteResponse().obs;
  Rx<CartUpdateResponse> cartUpdateResponse = CartUpdateResponse().obs;

  //Rx<dynamic> cartCount = 0.obs;
  var cartCount = Rx<dynamic>(0);
  final RxInt cartItemTotalPrice = 0.obs;


  @override
  void onInit() {
    super.onInit();
    // getAllCartProducts();
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
      getAllCartProducts().then((value) => updateQuantity());
    }
  }

  Future <void> onRefresh() async {
    print('refresh');
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
      getAllCartProducts().then((value) => {
        updateTotalPrice(),
        updateQuantity()
      });
    }
  }

  void updateQuantity() {
    int totalQuantity = 0;
    if (allCartProducts.isNotEmpty) {
      for (var item in allCartProducts[0].cartItems!) {
        totalQuantity += item.quantity!;
        cartCount.value = totalQuantity;
      }
    }
  }

  void updateTotalPrice() {
    int totalPrice = 0;
    if (allCartProducts.isNotEmpty) {
      for (var item in allCartProducts[0].cartItems!) {
        totalPrice += item.price! * item.quantity!;
        cartItemTotalPrice.value = totalPrice;
      }
    }
  }


  Future<List<CartItemGetResponse>> getAllCartProducts() async {
    return allCartProducts.value = await CartRepositories().getCartProducts();
  }

  Future<CartDeleteResponse> getCartDelete(int cartId) async {
    return cartProductDeleteResponse.value =
    await CartRepositories().getCartDeleteResponse(cartId);
  }

  Future<CartUpdateResponse> getCartUpdateQuantity(int productId,
      int productQuantity) async {
    return cartUpdateResponse.value =
    await CartRepositories().getCartQuantityUpdate(productId, productQuantity);
  }


}