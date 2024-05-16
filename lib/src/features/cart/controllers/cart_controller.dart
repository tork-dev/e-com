import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/cart/model/card_add_response_model.dart';
import 'package:torganic/src/features/cart/repositories/cart_repositories.dart';

class CartController extends GetxController{
  static CartController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> cartKey = GlobalKey<ScaffoldState>();
  
  Rx<AddToCartResponse> addToCartResponse = AddToCartResponse().obs;
  
  @override
  void onInit() {
    super.onInit();
    
  }

  Future <void> onRefresh ()async {
     print('refresh');
  }
  
  Future<AddToCartResponse> getAddToCartResponse(int id, int quantity, dynamic preorderAvailable) async {
    return addToCartResponse.value = await CartRepositories().getCartAddResponse(id, quantity, preorderAvailable);
  }
  

}