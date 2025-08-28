import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/cart/model/checkout_cart_update_model.dart';
import 'package:kirei/src/features/checkout/view/checkout_screen.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../home/model/request_stock_model.dart';
import '../model/card_add_response_model.dart';
import '../model/cart_delete_response_model.dart';
import '../model/cart_get_response_model.dart';
import '../model/cart_update_response_model.dart';
import '../repositories/cart_repositories.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  CartController({this.callingApis = true});

  final bool callingApis;
  RxSet<int> addingToCartIds = <int>{}.obs;

  /// Key
  final GlobalKey<ScaffoldState> cartKey = GlobalKey<ScaffoldState>();
  RxList<CartItemGetResponse> allCartProducts = <CartItemGetResponse>[].obs;
  Rx<CartDeleteResponse> cartProductDeleteResponse = CartDeleteResponse().obs;
  Rx<CartUpdateResponse> cartUpdateResponse = CartUpdateResponse().obs;
  Rx<AddToCartResponse> addToCartResponse = AddToCartResponse().obs;
  Rx<ProductRequestResponse> requestStockResponse =
      ProductRequestResponse().obs;
  Rx<CheckoutCartUpdateResponse> checkoutCartUpdateResponse =
      CheckoutCartUpdateResponse().obs;
  RxBool hittingApi = false.obs;



  RxInt cartCount = 0.obs;
  final RxInt cartItemTotalPrice = 0.obs;

  RxInt isPreOrderAvailable = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if(callingApis) {
      if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
        getAllCartProducts().then((value) => updateQuantity());
      }
    }
  }

  Future<void> onRefresh() async {
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

  Future<void> getAddToCartResponse(
      int id, int quantity, dynamic preorderAvailable) async {
    addingToCartIds.add(id);
    update();
    addToCartResponse.value = await CartRepositories()
        .getCartAddResponse(id, quantity, preorderAvailable);
    AppHelperFunctions.showToast(addToCartResponse.value.message!);
    if(addToCartResponse.value.result == true) {
      cartCount.value = int.parse(addToCartResponse.value.cartQuantity!);
    }
    addingToCartIds.remove(id);
    update();
  }

  Future<ProductRequestResponse> getRequestResponse(
      {required int productId}) async {
    return requestStockResponse.value =
        await CartRepositories().getRequestStock(productId: productId);
  }

  Future<void> getAllCartProducts() async {
    hittingApi.value = true;
    allCartProducts.value = await CartRepositories().getCartProducts();
    hittingApi.value = false;
    final List<Map<String, dynamic>> items = allCartProducts[0].cartItems!.map((item) {
      return {
        'item_id': item.productId,
        'price': item.price,
        'quantity': item.quantity,
      };
    }).toList();


    EventLogger().logViewCartEvent(jsonEncode(items), cartItemTotalPrice.value);
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

      Log.i(cartIds.toString());
      EventLogger()
          .initialCheckoutEvent(productIds.toString(), cartItemTotalPrice.toString());

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
        Log.i('All products: $allCartProducts');
        Get.to(() => CheckoutScreen(
              allProductResponse: allCartProducts,
              productIdsString: productIdsString,
              productQuantitiesString: cartQuantitiesString,
        ));
      }
    }
  }
}
