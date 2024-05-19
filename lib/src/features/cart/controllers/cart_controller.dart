import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../model/cart_delete_response_model.dart';
import '../model/cart_get_response_model.dart';
import '../repositories/cart_repositories.dart';


class CartController extends GetxController{
  static CartController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> cartKey = GlobalKey<ScaffoldState>();
  RxList<CartItemGetResponse> allCartProducts = <CartItemGetResponse>[].obs;
  Rx<CartDeleteResponse> cartProductDeleteResponse = CartDeleteResponse().obs;

  final RxString cartCount = '0'.obs;

  
  @override
  void onInit() {
    super.onInit();
   // getAllCartProducts();
    if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null){
      getAllCartProducts().then((value) =>  updateQuantity());
    }
  }

  Future <void> onRefresh ()async {
     print('refresh');
     getAllCartProducts();
  }

  void updateQuantity(){
    int totalQuantity = 0;
    for (var item in allCartProducts[0].cartItems!) {
      totalQuantity += item.quantity!;
      cartCount.value = totalQuantity.toString();
    }
  }



  Future<List<CartItemGetResponse>> getAllCartProducts() async {
    return allCartProducts.value = await CartRepositories().getCartProducts();
  }

  Future<CartDeleteResponse> getCartDelete(int cartId) async{
    return cartProductDeleteResponse.value = await CartRepositories().getCartDeleteResponse(cartId);
  }


}