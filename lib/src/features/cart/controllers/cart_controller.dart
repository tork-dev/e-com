import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  static CartController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> cartKey = GlobalKey<ScaffoldState>();


  Future <void> onRefresh ()async {
     print('refresh');
  }

}