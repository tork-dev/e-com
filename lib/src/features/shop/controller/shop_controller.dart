
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopController extends GetxController{
  static ShopController get instance => Get.find();

  /// Key
  final GlobalKey<ScaffoldState> shopKey = GlobalKey<ScaffoldState>();
}