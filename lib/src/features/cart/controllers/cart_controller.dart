import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/cart/services/cart_services.dart';
import 'package:kirei/src/features/checkout/model/checkout_summary_respopnse.dart';
import 'package:kirei/src/features/checkout/repositories/checkout_repositories.dart';
import 'package:kirei/src/features/home/model/home_products_model.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../home/model/request_stock_model.dart';
import '../model/card_add_response_model.dart';
import '../model/cart_delete_response_model.dart';
import '../model/cart_local_model.dart';
import '../model/cart_update_response_model.dart';
import '../repositories/cart_repositories.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxSet<int> addingToCartIds = <int>{}.obs;

  // bool callingQuantityUpdateApi;
  RxSet<int> quantityUpdateApiIDs = <int>{}.obs;

  RxBool shouldBulkAdd = true.obs;

  /// Key
  final GlobalKey<ScaffoldState> cartKey = GlobalKey<ScaffoldState>();
  RxList<CartItemLocal> allCartProducts = <CartItemLocal>[].obs;
  Rx<CartDeleteResponse> cartProductDeleteResponse = CartDeleteResponse().obs;
  Rx<CartUpdateResponse> cartUpdateResponse = CartUpdateResponse().obs;
  Rx<AddToCartResponse> addToCartResponse = AddToCartResponse().obs;
  Rx<ProductRequestResponse> requestStockResponse =
      ProductRequestResponse().obs;
  Rx<CheckoutSummaryResponse> cartSummaryResponse =
      CheckoutSummaryResponse().obs;
  RxBool hittingApi = false.obs;

  RxInt cartCount = 0.obs;
  final RxDouble cartItemTotalPrice = 0.0.obs;

  RxInt isPreOrderAvailable = 0.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      shouldBulkAdd.value = Get.arguments["shouldBulkAdd"];
    }

    final box = Hive.box<CartItemLocal>('cartBox');
    if (shouldBulkAdd.value &&
        AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
      // CartRepositories().bulkAddToCart().then((value)=> getAllCartProducts());
      onRefresh();
    } else {
      allCartProducts.assignAll(box.values.toList());
    }
    updateTotalPrice();
    updateQuantity();

    box.listenable().addListener(() {
      allCartProducts.assignAll(box.values.toList());
      updateTotalPrice();
      updateQuantity();
      update();
    });
  }

  Future<void> onRefresh() async {
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
      getAllCartProducts().then(
        (value) => {updateTotalPrice(), updateQuantity()},
      );
    }
  }

  void updateQuantity() {
    int totalQuantity = 0;
    if (CartService.getCartItems().isNotEmpty) {
      for (var item in CartService.getCartItems()) {
        totalQuantity += item.quantity!;
      }
    }
    debugPrint(totalQuantity.toString());
    cartCount.value = totalQuantity;
    update();
  }

  void addQuantity(int index) {
    final item = allCartProducts[index];
    debugPrint("Upper limit ${item.quantity}");
    if (item.quantity! < item.upperLimit!) {
      final newQuantity = item.quantity! + 1;
      quantityUpdateApiIDs.add(item.productId!);
      update();
      CartService.addCartItem(
        CartItemLocal(
          id: item.id,
          productId: item.productId,
          productThumbnailImage: item.productThumbnailImage,
          productName: item.productName,
          price: item.price,
          quantity: 1,
          lowerLimit: item.lowerLimit,
          upperLimit: item.upperLimit,
          isPreorder: item.isPreorder
        ),
      );
      updateTotalPrice();
      updateQuantity();

      if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null ||
          AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == false) {
        return;
      }

      getCartUpdateQuantity(item.id!, newQuantity).then((value) {
        // ✅ Update only this item's quantity locally
        allCartProducts[index].quantity = newQuantity;

        // ✅ Force refresh so UI rebuilds
        allCartProducts.refresh();

        AppHelperFunctions.showToast(cartUpdateResponse.value.message!);
        cartCount.value = cartCount.value + 1;
      });
      update();
    } else {
      AppHelperFunctions.showToast('Cannot order more than ${item.upperLimit}');
    }
  }

  void removeQuantity(int index) {
    final item = allCartProducts[index];
    debugPrint(item.quantity.toString());
    if (item.quantity! > item.lowerLimit!) {
      final newQuantity = item.quantity! - 1;
      update();

      CartService.addCartItem(
        CartItemLocal(
            id: item.id,
            productId: item.productId,
            productThumbnailImage: item.productThumbnailImage,
            productName: item.productName,
            price: item.price,
            quantity: -1,
            lowerLimit: item.lowerLimit,
            upperLimit: item.upperLimit,
            isPreorder: item.isPreorder
        ),
      );

      updateTotalPrice();
      updateQuantity();

      if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == null ||
          AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == false) {
        return;
      }

      getCartUpdateQuantity(item.id!, newQuantity).then((value) {
        // ✅ Update only this item's quantity locally
        allCartProducts[index].quantity = newQuantity;

        // ✅ Force refresh so UI rebuilds
        allCartProducts.refresh();

        AppHelperFunctions.showToast(cartUpdateResponse.value.message!);

        cartCount.value = cartCount.value - 1;
      });
      update();
    } else {
      AppHelperFunctions.showToast('Cannot order less than ${item.lowerLimit}');
    }
  }

  void deleteCartProduct(int index) {
    final item = allCartProducts[index];
    AppHelperFunctions.showAlert(
      onRightPress: () {
        CartService.removeCartItem(index);

        if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
          getCartDelete(item.productId!);
        }
        Get.back();
        updateTotalPrice();
        updateQuantity();
      },
      onLeftPress: () => Get.back(),
      message: 'Are you sure to remove this item?',
      leftButtonName: 'Cancel',
      rightButtonName: 'Delete',
      rightButtonColor: AppColors.primary,
    );
  }

  void updateTotalPrice() {
    double totalPrice = 0;
    if (CartService.getCartItems().isNotEmpty) {
      for (var item in CartService.getCartItems()) {
        totalPrice += item.price! * item.quantity!.toDouble();
      }
    }
    cartItemTotalPrice.value = totalPrice;
    update();
  }

  Future<void> getAddToCartResponse(Product product, [int? quantity]) async {
    final int qty = quantity ?? 1;
    final bool isLoggedIn = AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null;

    addingToCartIds.add(product.id!);
    update();

    try {
      // Handle request product scenario
      if (product.requestAvailable == 1) {
        if (!isLoggedIn) {
          Get.to(() => LogIn(), arguments: {
            "productId": product.id,
            "afterLoginAction": () async {
              await getRequestResponse(productId: product.id!);
              AppHelperFunctions.showToast("Request submitted successfully");
            }
          });
          return;
        } else {
          await getRequestResponse(productId: product.id!);
          AppHelperFunctions.showToast("Request submitted successfully");
          return;
        }
      }

      // Stock Check for regular
      if (product.preorderAvailable == 0 && (product.stock == null || product.stock! <= 0)) {
        AppHelperFunctions.showToast("Product out of stock");
        return;
      }

      // Mixed cart restriction
      bool hasPreorderInCart = allCartProducts.any((item) => item.isPreorder == 1);
      bool hasRegularInCart = allCartProducts.any((item) => item.isPreorder == 0);

      if (product.preorderAvailable == 1 && hasRegularInCart) {
        AppHelperFunctions.showToast("Remove regular product from cart first");
        return;
      }

      if (product.preorderAvailable == 0 && hasPreorderInCart) {
        AppHelperFunctions.showToast("Remove preorder product from cart first");
        return;
      }

      // Add locally
      CartService.addCartItem(
        CartItemLocal(
          productId: product.id,
          slug: product.slug,
          productThumbnailImage: (product.pictures != null && product.pictures!.isNotEmpty)
              ? product.pictures![0].url
              : '',
          productName: product.name!,
          price: product.salePrice!.toDouble(),
          quantity: qty,
          lowerLimit: 1,
          upperLimit: product.maxQty ?? product.stock,
          isPreorder: product.preorderAvailable,
        ),
      );

      // Sync to server if logged in
      if (isLoggedIn) {
        addToCartResponse.value = await CartRepositories().getCartAddResponse(
          product.id!,
          qty,
          product.preorderAvailable,
        );

        if (addToCartResponse.value.result == false) {
          // Remove if server rejects
          await CartService.removeCartItemWithId(product.id!);
          CartService.refreshCart();
          AppHelperFunctions.showToast(addToCartResponse.value.message ?? "Failed to add to cart");
          return;
        }
      }


      updateQuantity();
      updateTotalPrice();
      AppHelperFunctions.showToast(
        addToCartResponse.value.message ?? "Added to cart",
      );
    } finally {
      addingToCartIds.remove(product.id);
      update();
    }
  }



  Future<ProductRequestResponse> getRequestResponse({
    required int productId,
  }) async {
    return requestStockResponse.value = await CartRepositories()
        .getRequestStock(productId: productId);
  }

  Future<void> getAllCartProducts() async {
    hittingApi.value = true;
    CartService.saveCartItems(await CartRepositories().getCartProducts());
    hittingApi.value = false;
    final List<Map<String, dynamic>> items =
        allCartProducts.map((item) {
          return {
            'item_id': item.productId,
            'price': item.price,
            'quantity': item.quantity,
          };
        }).toList();

    EventLogger().logViewCartEvent(jsonEncode(items), cartItemTotalPrice.value);
  }

  Future<CartDeleteResponse> getCartDelete(int cartId) async {
    return cartProductDeleteResponse.value = await CartRepositories()
        .getCartDeleteResponse(cartId);
  }

  Future<CartUpdateResponse> getCartUpdateQuantity(
    int productId,
    int productQuantity,
  ) async {
    return cartUpdateResponse.value = await CartRepositories()
        .getCartQuantityUpdate(productId, productQuantity);
  }

  Future<CheckoutSummaryResponse?> getCheckoutSummary({String? couponCode, int? cityId, String? phone, bool? removeCoupon}) async {
    List<int> productIds = [];
    List<int> cartQuantities = [];

    if (allCartProducts.isNotEmpty) {
      if (allCartProducts.isNotEmpty) {
        for (var item in allCartProducts) {
          isPreOrderAvailable.value = item.isPreorder!;
          productIds.add(item.productId!);
          cartQuantities.add(item.quantity!);
        }
      }

      Log.i(productIds.toString());
      EventLogger().initialCheckoutEvent(
        productIds.toString(),
        cartItemTotalPrice.toString(),
      );

      cartSummaryResponse.value = await CheckoutRepositories()
          .getCartSummaryResponse(
        couponCode: couponCode,
        phone: phone,
        cityID: cityId,
        cartProductIds: productIds,
        cartQuantities: cartQuantities,
        removeCoupon: removeCoupon,
      );
      return cartSummaryResponse.value;
    }
    return null;
  }



}
