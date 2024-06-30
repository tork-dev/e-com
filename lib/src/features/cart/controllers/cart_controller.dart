import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/features/cart/model/checkout_cart_update_model.dart';
import 'package:kirei/src/features/checkout/view/checkout_screen.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

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
  Rx<CheckoutCartUpdateResponse> checkoutCartUpdateResponse =
      CheckoutCartUpdateResponse().obs;

  //Rx<dynamic> cartCount = 0.obs;
  var cartCount = Rx<dynamic>(0);
  final RxInt cartItemTotalPrice = 0.obs;

  // RxList cartIds = [].obs;
  // RxList productIds = [].obs;
  // RxList cartQuantities = [].obs;
  RxInt isPreOrderAvailable = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // getAllCartProducts();
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
      getAllCartProducts().then((value) => updateQuantity());
    }
  }

  Future<void> onRefresh() async {
    print('refresh');
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
      getAllCartProducts()
          .then((value) => {updateTotalPrice(), updateQuantity()});
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

  Future<CartUpdateResponse> getCartUpdateQuantity(
      int productId, int productQuantity) async {
    return cartUpdateResponse.value = await CartRepositories()
        .getCartQuantityUpdate(productId, productQuantity);
  }

  Future<void> proceedToCheckout() async {
    List cartIds = [];
    List productIds = [];
    List cartQuantities = [];

    if (allCartProducts.isNotEmpty) {
      if (allCartProducts.isNotEmpty) {
        for (var item in allCartProducts[0].cartItems!) {
          isPreOrderAvailable.value = item.isPreorder!;
          cartIds.add(item.id);
          productIds.add(item.productId);
          cartQuantities.add(item.quantity);
        }
      }

      if (cartIds.isEmpty) {
        return;
      }

      String cartIdsString = cartIds.join(',').toString();
      String cartQuantitiesString = cartQuantities.join(',').toString();
      var productIdsString = productIds.join(',').toString();

      checkoutCartUpdateResponse.value = await CartRepositories()
          .getCartProcessResponse(
              cartIds: cartIdsString, cartQuantities: cartQuantitiesString);

      if (checkoutCartUpdateResponse.value.result == false) {
        AppHelperFunctions.showToast(checkoutCartUpdateResponse.value.message!);
      } else {
        Get.to(() => CheckoutScreen(
              allProductResponse: allCartProducts,
              productIdsString: productIdsString,
              productQuantitiesString: cartQuantitiesString,
            ));

        // if (mode == "update") {
        //   reset();
        //   fetchData();
        // } else if (mode == "proceed_to_shipping") {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return Checkout(
        //       title: "Checkout",
        //       product_ids: prod_ids_string,
        //       product_quantities: cart_quantities_string,
        //       allCartProductList: _shopList[0].cart_items,
        //       isPreorder: _isPreorder,
        //     );
        //   })).then((value) {
        //     onPopped(value);
        //   });
        // }
      }

      // for (var item in allCartProducts) {
      //   if (item.cartItems!.isNotEmpty) {
      //     item.cart_items.forEach((cart_item) {
      //       _isPreorder = cart_item.preorderAvailable;
      //       cart_ids.add(cart_item.id);
      //       prod_ids.add(cart_item.product_id);
      //
      //       cart_quantities.add(cart_item.quantity);
      //     });
      //   }
      // }
    }
  }
}
